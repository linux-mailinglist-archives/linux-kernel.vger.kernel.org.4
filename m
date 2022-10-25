Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA360C3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJYGKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJYGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:10:09 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 23:10:03 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71DD20191
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:10:02 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2022102506085815766a8e3c237ac5fc
        for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 08:08:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fFrmI8K5lGuSst31g/cJjHTyF5NH3SrLB7GvM1NU+xc=;
 b=Zqc4I5uCMYFTE2RHCUvJiPtXeZyNhqhd9nmJjVovnNJ5hfvIEdjeLs79es2GOCViRvPsZ9
 HwdY5YdHl3dpSnDHfi/wS0pGhmu1hSavhpXkYUHLHDaXwqvfCw41w2hBjrO6oydukMNHMs8L
 dCijyl7uz0tEuZ/hcXPQALbOiJ2aA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     pchelkin@ispras.ru
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        khoroshilov@ispras.ru, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, pavel@ucw.cz,
        Daniel Starke <daniel.starke@siemens.com>
Subject: Re: [PATCH 1/2] Revert "tty: n_gsm: avoid call of sleeping functions from atomic context"
Date:   Tue, 25 Oct 2022 08:06:02 +0200
Message-Id: <20221025060602.2234-1-daniel.starke@siemens.com>
In-Reply-To: <20221008110221.13645-2-pchelkin@ispras.ru>
References: <20221008110221.13645-2-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The revert looks correct from my point of view.
I recommend to add it.

Reviewed-by: Daniel Starke <daniel.starke@siemens.com>

Best regards,
Daniel Starke

