Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8A65D8B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbjADQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbjADQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:17:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834AE65F0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:17:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 17so36390433pll.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aX4qFbxXDc8/pQ3FLxxUMK9+tpxxJnXa3MBNwFm11Hk=;
        b=aU61Csfpne5jFvXJHhBQiThOh9BRCssPYObxa0P+jgl44iEHlwf85MU23a0L01TpL5
         r2FJCokkPtN9YpKAK1kLHudPElUoBcatfs8ho1OK9/5SasLuxMZ0tSDCsE0JC8Q3RV3i
         ranONik2sNT0P+TM0LCp7DDiOKFY5yBx6X71wB91SlJKWdOf3XW+s6R5Nf+zDxXkEgG+
         ArNk3BpzLba3g7c95b448E8rQl2sA6UZxQ0Wo4hUps5Iv/0qXH5wH1FnwELt2c7GTw8j
         gx5Sm8vz0SNe9aksqDocPvhL/8Cv/RDsVxIOCDkneKwvCkSJtWqTUTHVnSSNhJU2swu6
         ZkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aX4qFbxXDc8/pQ3FLxxUMK9+tpxxJnXa3MBNwFm11Hk=;
        b=4ntdCZIUk4XygNWPI4KNeI+zYzj9HaZxzrCayfk1gGv1G2r0TpzO1uVKGpcNobsUO+
         yjYOXPYqcsoTkZYzHJguV5npr2+d5Uwv/N+E17/gaUOle6FnveKv7LYQbyp3mznkl0qo
         2BqkrMojb9+WK8j8cyS43mGWWKtdUkgJ1cziYVV5FLTKg9o5PuJOIdSep0urU12BvoBe
         gOXBAL99b/pD/BWtQV2jE+lrdS9ipAeqXH2U4W6x3GjN9avcTYk1ugev3bQ+Nf2eEhJp
         iSzcNKgOokb+H4JBeoMFxzjdvVzZeXtPuykg6dbqa0W6SKsm5UHpwpRN6V44VgNnNyEm
         BRLw==
X-Gm-Message-State: AFqh2krZUiQEe60JGtT6xIIABnjnzS+qiwMHoBROkrut5unmPKdkhXNw
        02ctwkS4qLbcefn3e7PsILO8QDZXbiMb132nwng=
X-Google-Smtp-Source: AMrXdXtudgqK5yUCV7eTCICEM+z5OlfEXRGwEmAHrdijtYyH9d8MiCydo6lFr95R+TenZEqoYh0fl3E1we8kf4bdldg=
X-Received: by 2002:a17:903:2149:b0:189:a50d:2a33 with SMTP id
 s9-20020a170903214900b00189a50d2a33mr2378402ple.17.1672849037031; Wed, 04 Jan
 2023 08:17:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7301:3c8f:b0:94:cc8c:6f92 with HTTP; Wed, 4 Jan 2023
 08:17:16 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <andrewcamron1611@gmail.com>
Date:   Wed, 4 Jan 2023 16:17:16 +0000
Message-ID: <CAGFyNuXZ=rfDSUmRYrXiVx0ra21psVxQmw=zMg3H7WGfi0tKaw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [andrewcamron1611[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [andrewcamron1611[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpEZWFyIEZyaWVuZCwNCg0KIEkgYW0gTXIuIFRoYWogWG9hIGZyb20gVmlldG5hbSwgSSBI
YXZlIGFuIGltcG9ydGFudCBtZXNzYWdlIEkgd2FudCB0bw0KdGVsbCB5b3UgcGxlYXNlIHJlcGx5
IGJhY2sgZm9yIG1vcmUgZGV0YWlscy4NCg0KUmVnYXJkcw0KTXIuIFRoYWogeG9hDQoNCi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCg0K7Lmc
6rWs7JeQ6rKMLA0KDQrsoIDripQg67Kg7Yq464Ko7JeQ7IScIOyYqCBNci4gVGhhaiBYb2HsnoXr
i4jri6QuIOyghO2VmOqzoCDsi7bsnYAg7KSR7JqU7ZWcIOuplOyLnOyngOqwgCDsnojsirXri4jr
i6QuIOyekOyEuO2VnCDrgrTsmqnsnYAg7ZqM7Iug7ZW0IOyjvOyLreyLnOyYpC4NCg0K66y47JWI
IOyduOyCrA0K66+47Iqk7YSwIO2DgOyngCDshozslYQNCg==
