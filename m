Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC069F3C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjBVL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjBVL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:56:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0123800A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:56:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so3448238plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm6mGYVm8lDp5WZDtqiGoAqVDkUuzuiLY5VqbWrdasU=;
        b=MpE1tKaMFgBI5+RIIjVVHOq+Uy59ZC2NTA1o9Hkfals4fn1uuz/icKZFisLU7E45UJ
         j0nFHYP8PJGVPI2B0+i7T0oJi6KRVRWMwNaVy/DQ5w1UyXPPo9XwYvaeAloK4CzgG6kk
         +vUeL+SuE4EyqpSNJJFGGVxWa4ZfiHKCbGlEs/Y3CE6i+akT8hxer2aeuVeXY1vVX7Pa
         +Gg8MZ+HloQp+zGtgMShn6+Q0scDpdWWcKLe3YI2+dIbbTasey+Har/erWEAjgRSJJuV
         tlhtGyrsG46k0tiu4vyP9pgEKeuYcIq7LDkfOkliAVzyOu+0PdkXsztBfXwbwaxcxoA8
         S9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm6mGYVm8lDp5WZDtqiGoAqVDkUuzuiLY5VqbWrdasU=;
        b=SQz0bc33fqHIUwr3dhl7MuycErhpSWMlLsazh+/YYNInMk3fjoKs4N9PFfx+Tz6cfa
         QCaaI4YpyJDOyEkShfwrnPpKOUjJlnMY/HYr983WBaKywlgsgxx1L/zBxoyGpftppuSk
         p42EdClvSMWkwerikOfHQSzzb+R21M8aKjr6DbSMWNydrXybsNGpRs3o2jnwtw7k0ILP
         poit+L7NQIJdOChkV1tah6O122NOB1cVZf4DT0X62XkPzzSvSAtUAdaAu1XCMSfuBz64
         5NB5W1DjhyZ/2mXojkSh41eDH6hfqwoBmVMzPri5SZUM3ClQC/LWHyns0vHuHoGO6TBd
         gOLg==
X-Gm-Message-State: AO0yUKV5NXqr5La6TbGVzTAnNOD8vVILmahMzh4n+EIxY8ST0fpPOhVs
        zRNw4Tv7xM7qqUOg4kk+wOiKZrVemzi2we+tLuY=
X-Google-Smtp-Source: AK7set/JeJq+/eZqi7CMpPgQAuHl4qSxleu0oLTMZM8u1KU7Oj5D2FbxBKzn+LL5ohqdbRHsup3IkYz4DMynbFHtKL8=
X-Received: by 2002:a17:903:2986:b0:199:6e3:187a with SMTP id
 lm6-20020a170903298600b0019906e3187amr1606663plb.6.1677066980534; Wed, 22 Feb
 2023 03:56:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:60e:b0:5e:684:c3d4 with HTTP; Wed, 22 Feb 2023
 03:56:19 -0800 (PST)
Reply-To: ronaldtyler35@aol.com
From:   ronald <konekabiru4@gmail.com>
Date:   Wed, 22 Feb 2023 11:56:19 +0000
Message-ID: <CAEnOMeSUYAfOkezuhqs_2kf_-y-76Nn4hry0ZSsP4GAypxv1Ag@mail.gmail.com>
Subject: =?UTF-8?B?ZsOkaGln?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:62f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5016]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [konekabiru4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ronaldtyler35[at]aol.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [konekabiru4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sprichst du ein wenig Englisch?
