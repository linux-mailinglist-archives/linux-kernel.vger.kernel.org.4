Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED8633357
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiKVCaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiKVC3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:29:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198B261749
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:29:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so10768954pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajce.in; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zzSpYLOL2FTbKVX+L0OU5nCGrpRqUSbDGNsoeqBPfw0=;
        b=FwXxYNc8K0gjJ73i4gGkiLWSDm415BPlTIekV/j4ioZnmTeF+/33uvI5bXxqq0PWCj
         RjhLK7HshsxiGMGX9knG4jAeqJ6h3tzjf4sOrN1UrzJPR2zjn2O7JiB86olIwELzRCNi
         o8yG6L0CTma3CXVLy5NZalBTfdfo9qRPIM9g8zJNbnQQZBawNELz9rY6mhG7umTuU61R
         TTYanQ2opEzc604ZWd387Hy1X8bF5kYs6E2TAyMj9SxdohpxccoNRqOiPFvngJC2s1a3
         R0DRF8/IHdGk6Wg1EJaQxFT1VtGxVf5P6BRRiS20canY9Wj4JsM9oqjVrjloKI4JEcZQ
         uESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzSpYLOL2FTbKVX+L0OU5nCGrpRqUSbDGNsoeqBPfw0=;
        b=Hih3Kuy2h36mX6PDCiNUOMMVy/DuyRc7Nga3Uds9/1GQVUD5NYtBM2bDyhRvqfchZM
         6z2eGAXMEYuNsbdx+b8sLh1/WIi9YrOLJg8M+P8EPhw5GOiqzjYSrbc+Ra2nf5s2onoV
         9+wwW2PxZlFlZBphCC6vaq4zGMQ5rEU1Xj9IddL7eczT0DdHohz/BTuikPaLiXeIB+J/
         HE2kNIGHNimlc6OOVxgrAvsrDuJHpBDUCYzCfQhGY7xzxeBGxOuYOD8GUcFGGO7E9aaL
         C9ujPO76li849ZLpxMSCM5OFztPSkYU7QwTzQCjLhd4/8fBtdBpxIH5sW0bcQPIPyRSi
         2+HQ==
X-Gm-Message-State: ANoB5pm7bs1baOI0x7RXK0dwYmAMl6QANjYAYmIT9DuPJs9Qw7EbON0p
        Q3Qvhjdi5V7am2wFXFvFwp8CCSrL9xkJpHkTrfatLDnBwkE7UZHFeRXz/KjqIyUOauRd+PVg21H
        n11RiCF7fm2JHXZF0ZkBguUEI4Td5ApcDXw==
X-Google-Smtp-Source: AA0mqf5eZiOdDndKC1rEL5FgBQ3mVRl3/6wg+f5czJ5Wry0mwEE8d7SXS0Vi1WpilQ4pn+d8arAjGWyvhjaeb8YpGD8=
X-Received: by 2002:a17:902:e886:b0:185:4ec3:c703 with SMTP id
 w6-20020a170902e88600b001854ec3c703mr3528526plg.165.1669084140593; Mon, 21
 Nov 2022 18:29:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:6149:b0:84:e6dd:62cd with HTTP; Mon, 21 Nov 2022
 18:29:00 -0800 (PST)
From:   "KEN EMMANUEL JOSE B.Tech MA 2019-2023" 
        <kenemmanueljose2023@ma.ajce.in>
Date:   Tue, 22 Nov 2022 07:59:00 +0530
Message-ID: <CAByN7qSCFvECYScnshzL1SXQ3NcRbStFT6RsWKEaUXYNJaP8zA@mail.gmail.com>
Subject: Re: justina kayumba
To:     plauzi <plauzi@gmx.de>, cielo17 <cielo17@gmx.de>,
        anawarp <anawarp@gmx.de>,
        linux kernel <linux-kernel@vger.kernel.org>,
        2 <2@news.t-online.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,GB_FAKE_RF_SHORT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_TONOM_EQ_TOLOC_SHRT_SHRTNER autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bit.ly/3GwZ2qV

-- 
Disclaimer:
"The information contained herein (including any accompanying 
documents) is confidential and is intended solely for the addressee(s). If 
you have erroneously received this message, please immediately delete it 
and notify the sender. Also, if you are not the intended recipient, you are 
hereby notified that any disclosure, copying, distribution or taking any 
action in reliance on the contents of this message or any accompanying 
document is strictly prohibited and is unlawful. The organization is not 
responsible for any damage caused by a virus or alteration of the e-mail by 
a third party or otherwise. Email security protocols used DMARC, SPF and 
DKIM.
