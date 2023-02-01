Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7C68605B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjBAHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:12:52 -0500
X-Greylist: delayed 1834 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 23:12:50 PST
Received: from walmailout03.yourhostingaccount.com (walmailout03.yourhostingaccount.com [65.254.253.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253F2ED54
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:12:50 -0800 (PST)
Received: from mailscan03.yourhostingaccount.com ([10.1.15.3] helo=walmailscan03.yourhostingaccount.com)
        by walmailout03.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ox-0004rN-0B
        for linux-kernel@vger.kernel.org; Wed, 01 Feb 2023 01:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=grabaclue.com; s=dkim; h=Content-Type:MIME-Version:Message-ID:Reply-To:From
        :Date:To:Subject:Sender:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BNWIenDKDE/rJsWT3z/BcBFEn9zY8Sn1XbkLDij0qSU=; b=W63QgRCB5shIhscgNCOKEZVBPw
        dGU2ScaRIh5OYE5x9gaAMys9TMJwS5fj9U66Q8E0ExZlXa5cvHBwBfauGROtzuzVNQIwICCSJSCpd
        A9LhUDrLmqeRuF+5pcJu61vSWx35tTp5ty8Nen3+866M6WpmaB4W4tdgX30/zSdAgJHMhlSsFjy9p
        JDpdcchKRD+2nk3GMEaV1qhGy6qxkIyJzndd/2PUl3aklnS9lTOFlslYX2OqAkLIdfubhIuoE27ww
        JQHy/MIxuvRbLE5JDWI4LXV9dhU7nbXVD4rDesDNlFBJqaG5tdxXh4Gswehgf3iHfOyKA51uyjYyC
        WTjo/Nkw==;
Received: from [10.114.3.23] (helo=walimpout03)
        by walmailscan03.yourhostingaccount.com with esmtp (Exim)
        id 1pN6ow-0002Gk-Ne
        for linux-kernel@vger.kernel.org; Wed, 01 Feb 2023 01:42:14 -0500
Received: from IIS85S.nt.com ([10.15.51.85])
        by walimpout03 with 
        id FiiB2900x1qHeCS01iiEM9; Wed, 01 Feb 2023 01:42:14 -0500
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from IIS85S.nt.com ([127.0.0.1]) by IIS85S.nt.com with Microsoft SMTPSVC(10.0.20348.1);
         Wed, 1 Feb 2023 01:42:11 -0500
Subject: linux-kernel,  please confirm
To:     linux-kernel@vger.kernel.org
X-PHP-Originating-Script: 0:d3dccas.php
Date:   Wed, 1 Feb 2023 01:42:11 -0500
From:   Sello Juaquin Dabeer <support@grabaclue.com>
Reply-To: sellojuaquindabeer@gmail.com
Message-ID: <f8ed505f7988438157f9077a1973a772@grabaclue.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-OriginalArrivalTime: 01 Feb 2023 06:42:11.0647 (UTC) FILETIME=[50265CF0:01D93608]
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8890]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [65.254.253.144 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.1 LOCALPART_IN_SUBJECT Local part of To: address appears in
        *      Subject
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02/01/2023 01:42:11 am

Good day ,

Did you receive my previous email to you, or do I repeat ?

Best Regard,

Juaquin Dabeer

