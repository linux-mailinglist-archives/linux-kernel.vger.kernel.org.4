Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BB86B5F81
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCKSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCKSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:06:04 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88EB132DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:06:01 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1755e639b65so9534476fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678557961;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=WKVV2ZrNPf790WoP/iMRVMm0XP1lujLEc8exXRtowgV+iPvqqJLV62vaLL3ZxJWaLa
         O7SFQt0ddHByQo6CfI+wv3r1EGgGFOHGOUtG0rTGmcM8ETX2DAfz1eB2ClR3luGEqZ0J
         LF0py/pToSbNez92IPBCxfj8FAs8QATjSS93orMvl0dfkgBJwFgMttt4mk0PkJaF954P
         5gYT2A/+ypR7oRbQDUkkHst8ArgrsNuGW6QL6Fnfs0fMUKhXa29nkCUKoGgbXe6uXLRV
         YeXDQeeip3DD9lTQ0z/mVdvQbZ7mCKTt/2nB0wdzQG4Shs6o9LxdUnkFlKe/V3Zkht1z
         z6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557961;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=vw/vrg50nku98VFH0m16yzxfwTlv5SI8zeKVeWEEQImTLRJQqhJh9LSeFce7T/VIcK
         xTwHzNPIYQUYOC8HhoEF5TFjxjHTv738M8wj4SwgJbe3G7bJdWzuhuwSFBLmJYK8aey2
         stZqA+AmrRqmorrQeapn2y67dn4hnNxWsGySEV9G80mUXOMcGtOw7lZiKUXI7JYPyqvE
         Cxq5P3HTRS94H3xrJc6aeKPMHGkDu/znM/Q2ftEKnzwuzzEPHKTJhsJFMMAG2Nt62DxE
         UcQn0FPlBBVoRaIV5fCj36sQONMxHoqyRhBxn78WveyJ7Mwm5fEqlDj1iVoS4+u7bnpu
         ZFIg==
X-Gm-Message-State: AO0yUKXfnPuJAChei9pkyNy6g0qBRDJQBh9wPinPqzadLuvcY/Al/w73
        twQJ/xSd/OedqG4nMWFJwcC+rDSyyea8UPZ6MB4=
X-Google-Smtp-Source: AK7set/9PeioIVXVuPUNZqReq5lYwop4XYFvefPRktQcxn9FEvnDLRNj/h5zgaThc24n9jhEhbm1s2asY+EkCSBxYlo=
X-Received: by 2002:a05:6870:d346:b0:176:2168:12a2 with SMTP id
 h6-20020a056870d34600b00176216812a2mr10550656oag.2.1678557960514; Sat, 11 Mar
 2023 10:06:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:b523:b0:103:d1f7:b1b5 with HTTP; Sat, 11 Mar 2023
 10:05:59 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <raqsacrx@gmail.com>
Date:   Sat, 11 Mar 2023 10:05:59 -0800
Message-ID: <CAP7=Wk57MN+CCeD8cmrfTBbrAZoMuY3kmmzPFYRkDX-imVD78Q@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5030]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [raqsacrx[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
