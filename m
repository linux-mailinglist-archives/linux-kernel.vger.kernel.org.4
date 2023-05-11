Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B26FE9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjEKCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKCzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:55:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E54C3E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:55:20 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so7255422a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683773720; x=1686365720;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWxp10o6SutV8Ut2SPOyU50CO9t0iyh+TuUkX3vQXfA=;
        b=NYK6l23tW2p5KZDBP+neWcgjB84EHp7wjFT3tgydpZYazQHeWxixEDEsRdvZDORCVp
         07W/ghrXzgqe+SHbmUmvtcN16oHwDCKsBReqyYXtoVVuioBmQeoYZEyJ3cm/d42wT9fc
         J+NHroIp9Jn7doGe6oatfkp440leJX2VlvnpYZ5vsZMcKxGvbTdsk5QIAPG2QcnuToCE
         qqwvVu/VLDQ2sBHWfokvT+E5mSIGT7Ne9XDEdJ332G9LmlSRthdgHl3IESRaiiiUp/9+
         YvnQxZWKKKPFLJCgdf0mxzilIsggC3//kt2e8cwA+dcZYierM4IGmcGcCsyg+aqIiV8v
         0LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683773720; x=1686365720;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWxp10o6SutV8Ut2SPOyU50CO9t0iyh+TuUkX3vQXfA=;
        b=B546YcBaJojCO0DUxkYItEmtAFKcd4yZr5YtJcwiNqHmKdFLF8FOdA3HjQVL3XYKd5
         ZJ7wv46W4Tpxeqfpi0GPerODY+edr8YLOUJ1wZGVJVdm93UqVBJnGh/xK2T/fxDNxkU9
         0YqHMCLm7/wnwiICAx1m2i8CswJNjBLureace52XaGBBGGjl6Yls90t+P5iRSa9myu2V
         2hsP4cph8sycWcHffkpPiQ/mBJbjdIxMikNA3rQ6XGSSF/tce9+JrcWCO/tMm9oO5wSl
         wvI5OemTKZtSYgMZA6PrZ1UQbAaTY2PNZwSBNA4mQnRil6iVLd18aKRl6U3b2X+AO5tc
         JW6g==
X-Gm-Message-State: AC+VfDyuz6gIjfcLd01+7I5OelLgLEVecQmdHJwhCCo6uqhmO/VHSXwL
        P8ESIBueIH6CZzsY0NMNdrPeRNb6AZGQwHDcOns=
X-Google-Smtp-Source: ACHHUZ6lplEvtlD5cZFapVCytxKuHlbZ8GU29n/oDa2sMSiL70RYZiTg6WuXNchGDs7g40OzS0sMvovb+uKCikrE/Wk=
X-Received: by 2002:a17:90b:1c8b:b0:247:26da:5de2 with SMTP id
 oo11-20020a17090b1c8b00b0024726da5de2mr19261305pjb.20.1683773720045; Wed, 10
 May 2023 19:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:cb20:b0:4b5:ad7b:f0a6 with HTTP; Wed, 10 May 2023
 19:55:19 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   Amadeo Giannini <idelphonse.aissy.apmterminals@gmail.com>
Date:   Thu, 11 May 2023 03:55:19 +0100
Message-ID: <CAH6fHsbdsUnE22qOsV0Psk4UqaYUxg03c7EnuAeWb5XdVdEZZQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you in need of a loan? Contact us now! Amadeo Giannini.
