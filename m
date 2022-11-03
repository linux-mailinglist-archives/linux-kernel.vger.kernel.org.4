Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C788618606
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiKCRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:17:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9A39C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:17:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k59-20020a9d19c1000000b0066c45cdfca5so1340164otk.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0VJEofFMv38BHH8O2mAmaQTotsMGoFX1NiiWvy0HEw=;
        b=MSPCIcw+/pNl5iDETWHFthWh9wjQXXEDwl6hjM3UMOVNiDQCtIh9UZ6Iloq28yLGlO
         BUw1TsW+s4HO81UGioKE/qcjMZKPfGDUVDmPO/NWfZyRmU9vWvFdouJPdAsOZKLgO4iH
         RDtDbPMabsJScyEKIefPShlRl7SUI41cAK2Fa9qkf2fWbIOli1Ja0w5HlPawT4Zj/ld9
         RHnHRvijscjS+ahbzoOZM56vI4SnioOaiJ0p/IwbiN3gl+Hat0wigO8KDp87vvZjmmj0
         syDzZ56RnCOwY0TLEwjXZsq72STchtYQUIjYeQaSVuXCPtTt2HOoCHHH23aVG3n4cRuc
         xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0VJEofFMv38BHH8O2mAmaQTotsMGoFX1NiiWvy0HEw=;
        b=Ag5ZABBhgErRltnfC5nLuEFzycooLpodMFzeHKSPZnL8BUiIuxjyGlzhZPiL4zU1Ya
         s+cYGFStc+v9NVePmCuiM6+rPC8Y1shi3BJf0g7ULWeg++ptXzc4MsBiHIRF5QrgFkVN
         roogGSG6GuI7hJ0TTgRjsKbXhTp2chotnixNeQZ6za/ATXY3waWAWmaDazWpSjRgE7I8
         gQT8eg5paxjvZJaW1v7Mikf3qKdrATPxTw5WK5tWKkW9QMMw1pH9tgIwP0fF1ishPnh3
         dDna0iK6mzF3HwvVZ2F1pbAhgni/NDcjt8AFzgyEdmu3mRxljN72WQ72MZJQ+XTaoM1K
         J4/w==
X-Gm-Message-State: ACrzQf0XL5GrQXv7UzntTO1AG9gfHLk5CoFIAJ6TUKAlOMwdq3x/gg3i
        ircC2q4WxstzjNdOdiFL4HZUQiwHfcZYHEnOxGs=
X-Google-Smtp-Source: AMsMyM6MrQ4+NnDyn1Bk3N4ZBc6rGf0Olcg5ZFJrcUkTguvBVTOavY96usNpdb4l5wTuw0kn0bkzJbMjvn9XubSl8b4=
X-Received: by 2002:a05:6830:2809:b0:662:2139:e184 with SMTP id
 w9-20020a056830280900b006622139e184mr15521835otu.110.1667495878142; Thu, 03
 Nov 2022 10:17:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:280d:b0:b3:b9ef:da8d with HTTP; Thu, 3 Nov 2022
 10:17:57 -0700 (PDT)
Reply-To: kelvinjones0214@gmail.com
From:   kelvin Jones <wilsomroman911@gmail.com>
Date:   Thu, 3 Nov 2022 17:17:57 +0000
Message-ID: <CA+L5qL0htbmm38A717SURwEW71DxpOkVXQvJ19ocQeGNPGwLLA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:330 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wilsomroman911[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kelvinjones0214[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wilsomroman911[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

How are you today, I have an important message for you just get back
for more details.

Sincerely,
Mr. Kelvin Jones
