Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F838646B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLHI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLHI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:58:57 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F3D48438
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:58:56 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-3f15a6f72d0so7590757b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+z6PSdj+SoyIJ7Nd8mIIgQ9Xnp6sfeNAskU/07pZxCo=;
        b=jSxpxvrsPiHvnSJI4ya5UcNrPjSDlxttFMfoVxtooPAPNQ1ri9nNmzFhsDvr17bS4j
         +9DOTeOb3+wklf1I17M1MFBgeLVVnzFExUHCXAs8o3ANjfTn8rKdozny680URh8jSjOW
         I5KbKdaIxi/5mRTiYnLj0oFsDCdL8GW05ppZ5qs7B3JsPOE9kuPPr57R36nA+Ex1hVgg
         COjwn53hpwlgcSDZbtFPNK/fjpzkCTD215PaN2KyO5umdNScxiI0LGKRhCJ02BgHPxIv
         36xkhI81REDNWqOj2QmUFl3W1nHV8UNTAnG39aTwvf6K8t7qK4sI17HBAjsx0v4MIc2+
         gOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+z6PSdj+SoyIJ7Nd8mIIgQ9Xnp6sfeNAskU/07pZxCo=;
        b=Im68EVT04xNRgvqgEjMSevSUAPuyvINGCaywJCVat4uOY1Z3Vb3EIKB+PDQHlB94C8
         6xu9fqEpp/7jfUpSDf8aftG5Q1EKgPvxslz97UuIhTBEq0WNnp5DxwjTLZZs23R2fN7G
         j/VrNXecXRrMaXqnX1p2pR85Sbg4Lyd8cbIaXpeVKFZ+U5kXel7LthzcIC9J7HXu5xDt
         8NBr1/zQ5Fd96aPMpV3GKceZQGIiew84MTl82I2mMi+AvSSkqHLxTqFws5DSCMj2QUP8
         wfF/UMyXCCB8vc0LLSF3BMyC48P4GDdlzMe2XHAPnx8mNXmoYN6R/wFHw/MQrPIafxao
         Hh9Q==
X-Gm-Message-State: ANoB5pkfJ0gSYgHRzlueeSBLOzRp6y+gvo2RgQmPHvyIz64dmU2s79s4
        6v/RuOT4kqNTpXjyFtBjiJYimdVNmCP0Nh4cBJ4=
X-Google-Smtp-Source: AA0mqf48KLvHUgHgxpl14MTOl0U6QBrNCSo7/HqJqyaWspTkyIW40GVbYwebZbJpQQTFh1pPD831pm5LBWMWLl3SLZM=
X-Received: by 2002:a81:8457:0:b0:3b8:1d18:90b2 with SMTP id
 u84-20020a818457000000b003b81d1890b2mr58578733ywf.520.1670489935026; Thu, 08
 Dec 2022 00:58:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:62c7:b0:313:99e7:bf0d with HTTP; Thu, 8 Dec 2022
 00:58:54 -0800 (PST)
Reply-To: info@oxfordfoundations.com
From:   Prof Pierre Louise <contractorvoller@gmail.com>
Date:   Thu, 8 Dec 2022 00:58:54 -0800
Message-ID: <CAJ7R6hniXdZh01ehU=pnThVgNftxTXqu8R+ooprQrtc5Q=1H3w@mail.gmail.com>
Subject: YOU HAVE BEEN CONSIDERED FOR THE OXFORD FOUNDATION GRANT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [contractorvoller[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oxford Foundation Trust
The County Hall,
13th Street. 47 W 13th St, New York, NY 10011
Email:info@oxfordfoundations.com
Phone:+1 305 590 8254

Dear Cash Grant Beneficiary

Your information mail has been received.

I am Professor Pierre Louise, the authorization officer hired by
the Oxford Grant Foundation; a British/American based charity organization to
coordinate the selection program clearance and grant release process.

The main objective of this selection program basically aims at
reaching out to individuals outside the United States by empowering
and to make notable changes in improving the standard of living of
people in the developing countries of the world and also in crisis
torn regions including places that have experienced natural disasters
in recent and past times.

Your details emerged along with Nine (9) other as beneficiaries of the
$1,500,000.00 US Dollars Cash Grant/subvention in the selection program
involving over 850,000 E-mail addresses drawn from shopping cash
invoices.
,
Once the above correspondence by you has been received and verified to be
authentic, you will be referred to our official paying bank.

Sincerely.
Professor pierre louise,
Authorization/Claims Consultant
