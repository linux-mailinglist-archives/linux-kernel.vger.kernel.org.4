Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D272F8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbjFNJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbjFNJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:20:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092C1FCC;
        Wed, 14 Jun 2023 02:20:51 -0700 (PDT)
Date:   Wed, 14 Jun 2023 11:20:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686734449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwyE4FJoz8w2cSOIWlMYfXcvxQemNB29XR/ZDxZG3x8=;
        b=KgXYcXKbAnNq1NsbYFZTrwStOSvHuxcyB84Et9H6FQKkvRJVTTJ5Nl3A0PxtczumxOCM56
        BLhzaL1FFvYhlZxOWSCUb1p7XJ9rb7A2xIL9Q5iKJ82Z6cprzu+A5M4Atc+Jnu+oKSUZIJ
        w0JLSDYzXawnsiY1Eq9Bg62qoSietlSPn9GMBbK4pUsVOJs0pbIbn3/4waCjdVeuQzelku
        5h4H4Vt6OmSeMeis9OGv6LaWLSIL5QASWbi0VgGTLf52b/AKnE6CzZ14BERGTHm9HI9Ngd
        +WlGU0gafQ9iG7rfE4eQ3emkPlFe4c9yHHl02WExVLxplFeXuae0pc71YpBEbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686734449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwyE4FJoz8w2cSOIWlMYfXcvxQemNB29XR/ZDxZG3x8=;
        b=uNd5x03JLHjui5vET+WBwfIcrL/YOEPkV5IB1HrSERbvdf1MEA/BrZ1BST2qkasdRS6mZX
        dOqN2TAh4dBCXoCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, luizcap@amazon.com,
        abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Message-ID: <20230614092045.tNY8USjq@linutronix.de>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023061428-compacter-economic-b648@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 11:14:49 [+0200], gregkh@linuxfoundation.org wrote:
> Oops, missed this.
> 
> Yes, there might be, can you do 'git bisect' and track down the patch
> that fixed this?

There was a report of a lockup during boot in VMs yesterday. If I
remember correctly this still exists and might be related to this
report. I'm going to have a look.

> thanks,
> 
> greg k-h

Sebastian
