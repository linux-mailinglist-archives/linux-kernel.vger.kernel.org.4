Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B463683416
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAaRl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjAaRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:41:56 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DE0577DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:41:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mf7so25185800ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 09:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVtlaBH2oW7gQDOB4EYMReZLPA6GM1pQjljM+jQPnhA=;
        b=jbBmOHVgpj9vI/nB8FVnps1C53CfWOLMG7s0wuIKjQTnHoj6zdqPXe2N8X9j3FrUEN
         iZkxB2+VPyBNl0O+UrXE4vlMgyf9fjLdD2Bn/l8mbpVgCDN0pMuxNJz+hsDi1vLxdFdZ
         7GrJt87rr0RhLfzHTL2Zm+rLm5mNNG0EkMC/jgS1HVFQr7SDs71PVtH6uOZ6jX7skZhK
         TwsY8Plrv5N6MouOf5WFjrKrpdyCjzVqkpIMay/Q2jrLTJ7ab0Wv4zSyF34b+X4C45MZ
         Xl/YZ1lBUlltjeubdBL+MGY8Tt2M18AAx9TADlQZCkS867NWlW4rwBnGibdYfUj5uDRB
         ENQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVtlaBH2oW7gQDOB4EYMReZLPA6GM1pQjljM+jQPnhA=;
        b=plNcurw1eXE8M+fDsUGbBpmouQHQYUlKGinltEgy5nLwTHEdvp+LRKNA4vgj49XgdU
         Kk7E2B2WMaCy0juWW6Ea2lAM4cF/sQD1b/YIeycuYLipL0S8FiNG8BSGHkNixoGc+Av+
         z/zYqnWpD5bPb+l9YNGZpesTeT/Ot6zHkg98wcbq/fjxU0AX8sB75bHn60oD1450qBjw
         lQQADAEa2QiaTii0gA8mAUV9MoGJS9xu2G2MUKV0T6RPsyO+JJyAxUvCMLzIQ/wGZxcS
         +lmVhy7GGjvL79Y4YtDgZfnCO/0tYXdBV1OjAmCkorPpMwLfXx2l8GIruOlcyNp+iSUz
         HQPA==
X-Gm-Message-State: AO0yUKVB/0aL5panasfeq5rE7eBd6oBSvcyf53uOt6AJf/17ywbuWVC7
        M90hbjijv8NoYVV7Y3Q7fjguCbGXjEJtH6o/HwE=
X-Google-Smtp-Source: AK7set/B6zfBUrcsB8u0YzGzbM9oU0cm0kSsBHJEPlN+nR+fkTMxgGY4Oz7lDsT9hlLJeFmyyrM7l/kce/u8WAJiOTk=
X-Received: by 2002:a17:906:7f0e:b0:88c:b87d:b771 with SMTP id
 d14-20020a1709067f0e00b0088cb87db771mr719769ejr.195.1675186913688; Tue, 31
 Jan 2023 09:41:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:4291:b0:62:7391:d678 with HTTP; Tue, 31 Jan 2023
 09:41:52 -0800 (PST)
Reply-To: innocent_iddrisa@innocent.com
From:   Mr innocent Kanazoe Iddrisa <sec.susanakone@gmail.com>
Date:   Tue, 31 Jan 2023 17:41:52 +0000
Message-ID: <CACHxTFwN_uCVXvTU49gYB3iTqLtfYuCG_GziyHk33OppH8xkOg@mail.gmail.com>
Subject: Please reply me this mail today.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sec.susanakone[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings to you.I am Mr.innocent kanazoe iddrisa working at the coris
bank international.I have a transaction that worth a total sum of
$18.7 million dollars to handle with you.Reply me today for more
detailed information if you are interested.
