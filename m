Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F995F6B25
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiJFQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJFQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:03:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487AFABD5D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:03:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f9so2718706ljk.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4qOPHf7RYg8ix6/iJMuNMtc57OSN/VOcyt7Dw0D/k=;
        b=kaxURPByARym3j88S7RbGuOMWrlSqzR58TwszHEpHAnJlAgYKbRC0DDDufkNxdX+ip
         g0Bn2jTjA//Zw6KVGy/Fru0V2hfnlHjPh9mCHD+Ooq8UFFIPvZpMNvxeQ0IY5sSf9Vv0
         YAOBuXVh9gg6y6xsLophUOqjAbMRWC+SnvILc1I2yzjLvZrQ7ks7j56occet9/s0Phrn
         A8SxcHGmJl9lgJ1F4dLXqP88l3g26/Dt8MIvYC/tOxOEG5iR283wUof6tBe6hIwmxjtO
         OdG/fXfqV2vmMm3Y12MqD6+tvGbXkVN/I8+dL1mcqjM/+U6T6Pru6yqslZM2yNAwWMez
         r+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY4qOPHf7RYg8ix6/iJMuNMtc57OSN/VOcyt7Dw0D/k=;
        b=YrGRgA10gGADD/f7CuE2SyhvkiA8DJLK1bQrA2CJBrYMa8gOpJ4x0+x6Bd8kYIbczH
         Da9vs89ALRDWyLZq25fLoeZCFrCn1tGitithFI+1bGcN7YBg0mbRuenkAucftWtNpJt9
         fkMo232Atd3C0PYwsmWxf4A5xADoGDL+kpPVw3p+sngPrN2I3PxmT3kBhNDMAfY2jlds
         4+fK0/xaE87em1yvl5lg6R+iYeEsYwVtTnJ4YyP+TFNBpGB1hcgZzK/M48IsI+1SKWTE
         EL6NYYhoz5TX2o1e2GQUJDIPEqBSo9UjD0n5wbxViB/boLyf+VDkDH00YNccNqcp7Fkk
         cRtw==
X-Gm-Message-State: ACrzQf18L2UPCP+xywa7bpitENUJcbMyeihOhY+9qTJlTXjGZNe1HiAV
        /swZVzazS/KAu8e1Y2SxQj467kqeDg80pj6xcFs=
X-Google-Smtp-Source: AMsMyM7y7AN3D05bm9rhh4WAoXxmX9j/ycW3uM9Paggd9p2eBELuYB6uvwdk6XSsCa4RvcgjGXNcEqNS10gXfC4woBE=
X-Received: by 2002:a2e:2d0a:0:b0:26c:a1c:cdf with SMTP id t10-20020a2e2d0a000000b0026c0a1c0cdfmr145675ljt.352.1665072212496;
 Thu, 06 Oct 2022 09:03:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:59ca:0:0:0:0:0 with HTTP; Thu, 6 Oct 2022 09:03:31 -0700 (PDT)
Reply-To: financialdepartment094@gmail.com
From:   "Financial Department U.S" <graciang96@gmail.com>
Date:   Thu, 6 Oct 2022 17:03:31 +0100
Message-ID: <CAJ3nXd3NxVduP3dOMifEvyGknoZhwBxzJyCsmH_-zAJXDM-A0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:244 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [graciang96[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [graciang96[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment094[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear friend,

I have an important just get back for more details .

Sincerely,

Mr Jones Moore

Deputy department of the tresury

United States.
