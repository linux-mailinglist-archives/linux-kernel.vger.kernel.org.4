Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E40B65BD59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjACJnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjACJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:43:20 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7D9DF4E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:43:19 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x11so6901205ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsv6sMQmC8jnqT/6rqRjPIfpOBvg88+WOYXR6wIOiQA=;
        b=aaYUNqpwbWB0pTvKr0QvVzpNahdIOHtEA/yFBk4icioi0bYHp92GlFsKytEfEIMLTp
         iMffQSbnUfkSzgeyyeAadaZbYNRSv5bzkoCA8jlsMflgyqK3gOmAAZw2GZqNnkLNHQvU
         QYORQyC2An/C3PbTYixALsxl4x4MYgmLPR9ZoEtiJKwK3eOuO8P7xIlRX5onrrdQI+pH
         2apl7I1V4E7nePbRTS3JnwcqQN8OraMA6i0Jr+cRF+l5Hx+qHi3cEZ1kbA1CuHuXxmMR
         OUShOMREb802q4PhYgKATZHKEa8mpnj+/v+wZwsXuXPL+uTAKPQlKEvB2XBANpeDl8w9
         wGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsv6sMQmC8jnqT/6rqRjPIfpOBvg88+WOYXR6wIOiQA=;
        b=0M0f+cncFjs138gdKPFA2M3M3nT5OE9jf2xmGyQz1E6KgxtplqNN93HEofEBSM0yhR
         luAAC2wRNdh52SLLLEiRp6n0nQaVP+BAxT3qRZya4FxfTrBKEL8ryWzV6XodRPEoo69A
         EnDiORAeWJ2KQX0nnHHemqu+x9XcszfM/AhNlcmfyPjDpTcpXi15oZovtUPPe0Td6v+I
         jpWPG40/aeArtuxBXbf0HV4bv/cIqiqmmInoqWb0wcJ7N/rxSOd6UvH1WaRCFWcum6BB
         G6lEmOs2Q49y7Fig1gMGSzV8K4RndMY1JDB1OACZd7V9aQoCKdCWe0ZybqDcSUrJI0X1
         8IPw==
X-Gm-Message-State: AFqh2kr0SyB6g79y+OSDYTbxrIBuYinWNo1nMyP3wWmb9B2CFXD1bMi6
        rZpTfH1vHCe4OJM3HqyOQFJw06o6cr77HI7RwGo=
X-Google-Smtp-Source: AMrXdXsP8NJ5T+1HfjpQazSQRW5NnvOtpPziqNWPrddpfqopFqla003vGdxIaQYwOwdkzs/lwNyZpvDzPL0BXnvlCY8=
X-Received: by 2002:a2e:a4bc:0:b0:27a:76e:748f with SMTP id
 g28-20020a2ea4bc000000b0027a076e748fmr1615962ljm.467.1672738997331; Tue, 03
 Jan 2023 01:43:17 -0800 (PST)
MIME-Version: 1.0
Sender: lruby0209@gmail.com
Received: by 2002:ab3:4e06:0:b0:203:9497:de8c with HTTP; Tue, 3 Jan 2023
 01:43:16 -0800 (PST)
From:   Aisha Al-Gaddafi <aishaalgaddafi112@gmail.com>
Date:   Tue, 3 Jan 2023 10:43:16 +0100
X-Google-Sender-Auth: eRdqpigJ__Rr5WBxBkFov5t7ZGs
Message-ID: <CAEPObtMMB8-A-jYnqhJ_ZSEkU=EyOfBCmWW-MsPWOojmAG6-DQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

I am sorry to encroach into your privacy in this manner, There is
absolutely going to be a great doubt and distrust in your heart in
respect of this email, coupled with the fact that so many individuals
have taken possession of the Internet to facilitate their nefarious
deeds, thereby making it extremely difficult for genuine and
legitimate business class persons to get attention and recognition.

I am seeking your assistance for the transfer of Twenty Seven Million
Five Hundred Thousand United State Dollars ($27.500.000.00 ) to your
account for private investment purpose.

I look forward to your response.
Mrs. Aisha Al-Gaddafi.
