Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC36C37FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjCURPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCURPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:15:44 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551B51CA0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:15:14 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17e140619fdso8431492fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418911;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XUznw+96Gvbv6IKQqs+2rZZtbVe39fwnOoVFI2nPG5ph1XDSrOoFlgGtZZOMMNZqkS
         5B22oCsEn2E9e67YiO5ZvIC6YezoTJ4h3cRaMoMIARAqtiEWe8IoSDOQTq4CmWCgmLAa
         XsGjrDyMWIzy4AjrVkVgdCjWzw76xWzk/za7tbsyvLeCrBlgPyRcYIU8zIcChwLXDi0N
         gJ/WALNVVE7G+nKgVe9tUOA3/QSOo6xu+Di0NT+qquq8Qd3pxj7t0H/mPp2+OYdel34/
         XHbsEkHn8poLqQhXWAehp8Wp0l/MLeMLPzGG8TQWwdtzQZD1Gh4fpjALjWylsW2Fj0pe
         HFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418911;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=01krKy/BfZhNO3ku5uE8IJymXs1TFD4T9wdU5boIpEFgIENowR/m44WBErci9jzirr
         3elzQdB951u6lSkZ7Va0TKDQg2AY1tHkV2I35i3/QhNQJBr/UPVUbhixQlPT8hBVzsju
         MDop+LD3RxeCSviRmh+5wLtDSMacrHqDN3ghePk65E4ScKWtNIhkSJKZ4dDXeQOwf8oi
         kEWV6KbNobUbgsvpCxT7YgeF/dA8gdYGl7tfg1O1m1bgEIWSUD5hnIOPLslc5lUq4RlQ
         6U5H58/HbwISp3Y47pXqMYxzVJIMMUZ4PK+ghz58hpGZN6gXVBN63lT53A1/y31BrBOh
         icCg==
X-Gm-Message-State: AO0yUKVerdRAqzC94VPy4DypXRC8khy9UXsS/wjxvJtBCKi/lya6/2Bn
        VIOV0gRyTFEt6Ff6ihRLK/d43wEgyyYs7ifGw8U=
X-Google-Smtp-Source: AK7set8CiXlyx7hzzxpseyVlUmDHp99JlIkN/AFr3W+rMb0nuvbJsyP126GBZER25zBOPku4GiBIyob849AHOpLkZII=
X-Received: by 2002:a05:6870:13d9:b0:17b:f094:5478 with SMTP id
 25-20020a05687013d900b0017bf0945478mr966678oat.2.1679418911232; Tue, 21 Mar
 2023 10:15:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:71c2:b0:eb:2713:ca32 with HTTP; Tue, 21 Mar 2023
 10:15:10 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gte263531@gmail.com>
Date:   Tue, 21 Mar 2023 10:15:10 -0700
Message-ID: <CAOJy87n+mvr54vRqwuwc2AWpVjZjEr0zPyrbSZTAgvhifprpbg@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5011]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gte263531[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gte263531[at]gmail.com]
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
