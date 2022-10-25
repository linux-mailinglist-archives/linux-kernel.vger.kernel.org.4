Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C260C3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiJYGLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJYGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:11:29 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 23:11:27 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43186D873
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:11:27 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20221025061020ea657f904c29eba2e4
        for <linux-kernel@vger.kernel.org>;
        Tue, 25 Oct 2022 08:10:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fFrmI8K5lGuSst31g/cJjHTyF5NH3SrLB7GvM1NU+xc=;
 b=i0VJrI7xQzuVdDbAyuqhX+zWiPv9qjfAmctbxRStD5rp+d4TRYdVSCyuI5p+HLyavvaQsO
 RR4DU4o8qqZhBn4tqviQx6SD+4ws0dG9a1qUhoyd/KwfAH649w9X0vzA2uLCf8/fqs06ocnh
 Wn2GZla+5gJNG7poYXiGkuo3pJ34Q=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     pchelkin@ispras.ru
Cc:     daniel.starke@siemens.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, khoroshilov@ispras.ru,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        pavel@ucw.cz
Subject: Re: [PATCH 2/2] Revert "tty: n_gsm: replace kicktimer with delayed_work"
Date:   Tue, 25 Oct 2022 08:10:06 +0200
Message-Id: <20221025061006.2311-1-daniel.starke@siemens.com>
In-Reply-To: <20221008110221.13645-3-pchelkin@ispras.ru>
References: <20221008110221.13645-3-pchelkin@ispras.ru>
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

