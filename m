Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6B69A8A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBQJyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:54:51 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F55F266
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:54:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id i14so2259466ljn.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=OQExkPUyHPSKyUz+617ZUxO1gI5rtYd5dt0RGFx9Jxy5segsRYZjal82u8ujUw7e4V
         pudXcEsW6zLr9rOV4sIess6exchz82J4ZYZAdocIaZcvtYsIijql0uPC1mxkSQ3vLesk
         Mza4pUGkeiXRQXoq+euSMvwBxAcXHTHLZVjn1HdhNFo92t0UtqMdYv/rK9lCqKxQASFB
         6H2A5k1r5MMAACjJBwuqB2y4/aHeiywwCK3BuMDXxcJZMvdEhjOB521jWKaDT0gPqiTw
         f4kpuDpQmEqrx7WCyYGryTRo6qtZJn19vPNPEHWU7EsfN4dRykfFBDRiUntnq/BhXA/x
         ZVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=h0H9KMU8BVAsZtRgVuTrnNsurxoGT7Y3WdzMGrNAx1zxv2hLyMN9fi7QCZ48j5nFt4
         Z0K12LmjrNRacBL7fyx1hxL0OTrxfLlGYvKQtSUkbiR2W675AoQpRbW6WHiddJKfeL09
         ggWWXuvwe3ICi2FonmYp0dryQjj+CANbGvvl+GpeQNu1sc7sesI0EZIHfh0uHeOQqEsp
         H3fjrzDqsxPULDByYktxe4CwNd8AF1xjn/5Jwcx+FEtsgQs6DbwOadYiQe9x4tZh9SsT
         AoROTG535KNcI0so/VOfP4q6uFQ2u7I0K1oB+gTFNmbsYA9lGbP8L3N3ooQWQOf8C6dg
         toiA==
X-Gm-Message-State: AO0yUKW3j90hHM3OAblctLQU4de9huW2GV24urD+FIa5SebbwcdGq1hd
        d3CisPc/HI/42j2Hux7n6jmklOA6LkXpbw3HxMQ=
X-Google-Smtp-Source: AK7set+cgqyCJtgI3S9dERldAZ9bX/s6JgKXbYvtTyEXj2Rwuf/xO8lPkdeqpEdjsJOkzM7UzNLinYV/ikiK5SI5NAA=
X-Received: by 2002:a2e:b558:0:b0:293:34f2:1e40 with SMTP id
 a24-20020a2eb558000000b0029334f21e40mr183467ljn.5.1676627688696; Fri, 17 Feb
 2023 01:54:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:8d:b0:38:f0e2:4d84 with HTTP; Fri, 17 Feb 2023
 01:54:47 -0800 (PST)
Reply-To: elvismorgan261@gmail.com
From:   Elvis Morgan <elvismorgan220@gmail.com>
Date:   Fri, 17 Feb 2023 09:54:47 +0000
Message-ID: <CABF8GFdWnh+rAL6gyoaqiVrvp2wW3Hr4ROw1saLQ59ZsdkPYEg@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elvismorgan261[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [elvismorgan220[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [elvismorgan220[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
How are you?
