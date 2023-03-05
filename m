Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0363D6AAE90
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 09:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCEIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 03:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 03:20:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC639014
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 00:20:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so26512499eda.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 00:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678004447;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=eHXA8pVDliWIbb1r2a0N52DTxiIayaflfCLNyqZh0HzUTfE29506nW4k7ShufovRhP
         8/UB/NaXMdQ6UeuySEsnJVApEH+zhdTh83sU2c9zktoOJJeWOZnX7sKj1n/7XQUHhjpo
         a376Ty8xPj0I9bNA4oDeRE22cmGFA+Ef3hqYBdlDyjOwo00ou7e4usbrBTyXrCcu1a92
         Dtrn/2hPg5z5RIAUFhVbP3WgpbwrBJDOy3yhFkQhqzaT0kq4y/SlCXmmVo/87vRt7rt7
         XnE8GYhoKCUjdcLNDcm0Sf9YYqTrSV2YB95/UtaXZUSLbR6WBClkHClsEL8FLKbqn6iB
         c40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678004447;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50Qlw1MrbKfPc5Y3tqZO5+1c26Aew+5oqPX3JirLAY=;
        b=hzKELIXBx70YpiKlqttfeRCp4Ejau4eqLLt7mKsSIzgpe6yNUtSTERd8t+1ZGtNRMK
         727K4S6BJvE1XOoYLTxdz474QYIGpE+gxa+a8190rt09Odv1dE8BCexIlEEIouy4bUBq
         wfnrSRcL4AnettOikxUbnaDwn9eq2TNLSJaqy1UGEz+a5HEtdaHCG1I1edTe5lb15ztU
         Wo4gyDs1avkSlvs58FZIQk3jkz3z52fLyoYtG88oTYcoctRt0NF80dwjHlpdFCes6NTg
         wjMrIj5rET1XqpuObzX7I1bBrtmbUrYI7VNw0h+YvUwTZ7f9Q8IvSWDXsND9GldlKsE1
         o3Dw==
X-Gm-Message-State: AO0yUKXc0DGF4F/hkc45+4u7iPYN9sQ8HS4ZBNx6euYcIaTpDGEqun/m
        yhAfS4rflW0oyptNg4MpuAvq2fnbi+q/YYJeZVA=
X-Google-Smtp-Source: AK7set9uJSc3KcKr7oA2CZN9oLrfpNigbb6rgPG6vHurVAnfTbex4bLPZdFQ4uL/Q1DTfEkmwuqdEflcEqJNYtZHZ9c=
X-Received: by 2002:a17:906:388d:b0:877:e539:810b with SMTP id
 q13-20020a170906388d00b00877e539810bmr3369286ejd.2.1678004446923; Sun, 05 Mar
 2023 00:20:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: xzcvxc289@gmail.com
Received: by 2002:a05:7412:a90f:b0:c1:1578:494d with HTTP; Sun, 5 Mar 2023
 00:20:46 -0800 (PST)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Sun, 5 Mar 2023 08:20:46 +0000
X-Google-Sender-Auth: kN4ZuyAi5GXd_FC46xEuaOTcbPA
Message-ID: <CAJD_Hb45zwEmW4FimuUjUyAQh8_pS+9MEc3p4fCXDWA79GND8Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8416]
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vandekujohmaria[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [xzcvxc289[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, how are you?  My name is van der kuil Johannes gerhardus Maria.
I am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium.  I would like to know if you will accept my
client's donation Mr. Bartos Pierre?

Waiting to hear from you soon
