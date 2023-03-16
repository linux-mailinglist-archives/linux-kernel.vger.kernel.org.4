Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE546BCAC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCPJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCPJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:27:34 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D75B7D89
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:27:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so4852082edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678958840;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Am4l6xMhb1vP5dilYwx3GXsl0GLDDzlZh+2OHdXw3E=;
        b=S22BQSMOhc67lmchHChq56D944nMKduaS8BUh0D5MlnB9rjlgF4lVssG12DMHX38Mo
         QXguqzMx45O2HNy8Z3wso8HRnxs7NrqIf+Qpq36QplqA4FbZE1guN64Q4oNM+4qhEapp
         SjX/YRhU0LPtaBxw9+SygEMYf+paRqFBhjcIGo0fe6Uv4EKUTHpx5pJvpncmJuo44jXb
         xYNlU5VB+zZ97kMaytRGJqaehWne3nXMcCoys6usNVXz3l7OSRUENCY2qYHwGzN2bVaU
         dfpGNU6UyU3Ra/OcLNXNSb1F+W1Lo1vYLXvQVZHBU34v63qztMe6BJ/x0xaOh2tEsdcG
         oHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678958840;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Am4l6xMhb1vP5dilYwx3GXsl0GLDDzlZh+2OHdXw3E=;
        b=md0dsOzhMP/kxUXKRThhxY3Ycj/pNjKBOSshnDu9fQAPTF2YCmFB12g7bd8Ww111k6
         P4Iiy83VImX+9coxRKBB9jShiI39n0XaRYQJ+boXlj78cGcnNaoeHZSPulrA/J4HHai4
         /SOhxpihXp54jy6V1ReT7hpixUqR+S29QPWR9Y4e5z0vshRveFIjllJsE31mcCkMs1yd
         4TuMFu+jx2T02Wz6QgHVFI28w1siNXuEeyE9SFAmW+NXfxxpYHzMwicWyodLURYiTwqK
         hwDfcDwPvSOYcrcKNInGKDSeMriDb4zxnKkXJ+s31WsG28TB6cj64LLID8cvQ7TJY34D
         a/MQ==
X-Gm-Message-State: AO0yUKWgIoQSm1GX0bJul6mBNDs9aEPeeZATnNZetFIVexEWKhiqKWHq
        g2M2EtW0WgN4hN6eD3ByHqPy/n/TEVfOw9FF5a4=
X-Google-Smtp-Source: AK7set/rd7n6OFPsMVd8VZUnfm+DpVbLao1YgEyh16GEnT/5dmhBspHPgbr+AipmDEs8NStAwYll7V5pNP6ku8Uz1y4=
X-Received: by 2002:a17:907:8a12:b0:92f:cf96:e1f6 with SMTP id
 sc18-20020a1709078a1200b0092fcf96e1f6mr1742286ejc.11.1678958839900; Thu, 16
 Mar 2023 02:27:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:3a4:b0:46:2cca:b161 with HTTP; Thu, 16 Mar 2023
 02:27:19 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <claudiayahya2022@gmail.com>
Date:   Thu, 16 Mar 2023 10:27:19 +0100
Message-ID: <CAEbGVRkP_Mn7fLQ8qRwtyi7VbV2V+bZYAEMfJbMqN47rc62sDg@mail.gmail.com>
Subject: FOR INVESTMENT PROPOSAL ONLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5760]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [claudiayahya2022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [claudiayahya2022[at]gmail.com]
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

Please are you capable for investment in your country. i
need serious investment project with good background, kindly connect
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Yours
Amos,
