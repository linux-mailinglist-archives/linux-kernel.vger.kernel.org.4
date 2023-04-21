Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6133F6EAB91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjDUN1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjDUN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:27:35 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836ADD322
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:27:29 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-541b60e0a7fso1057320eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682083648; x=1684675648;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=INYiRZCVUBLSzSAvbeLFV7LQVhXQlmAmrLc3qHqFuiKoP49Kvr1rJil7YtjMfxYbg1
         HECmzJP3eN4h57bcYfr+e+p+vuP3ms2tSKWCCBZzLday4YOhuRLzWJ73GIVZM3OKEcDe
         P7B9iXIkTF1qZgN5TS4Mn2FYfgHoYZ0Z4MkEQhOt4McW3QQACFTOMopEsy2z8rv/HtJ8
         sFZ1v1an4XMM+qeZHa7N1ejBZYlnkCJmqtukFpX4+Ly5WdRC2CeMLtV4AfomQVoh5WN2
         MGtKhadaBwNGMT0tecMBQzq95ztnOf8k+HACtAxWE1zvXIaDVwj9ZnnDqjfGoNygqH1n
         4dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682083648; x=1684675648;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuEcBNI44bQPUlx25Dk5iSkVIfTfkFa2bdyje0ZPA4U=;
        b=G9EuFYqPNEZXJq04Lvtn1dFQ/qW1ijdtSUGK0UPpzDqhUn11T2l+gX9d4aIlSJmtsY
         4neP/E4SB6Dn4TO88bugW++5loKX3Ku/DP1OeTo+f5DxkBwA64gD1mLQMGHaKTUzJKgi
         m9S1ROFIAMYk6Vmr+aMRnZMbJiv3OvR2nk26oQHg0EfyVp9EA9EtPQoOCy0TY0dii6p7
         Ipnj+rxkhSc65Bmvv/b3NkD9FKYIxiHf8WclD+WzdyDtjHGaJGXhrUV/7hzDUejUZ5+5
         2Ni1wfrdKtykFP7WfZ9wQL9Nx9ZEMj6Cdy3wdIFx4Kkq+sgPhEisEg4Grwr45wM3ANyD
         Ec0A==
X-Gm-Message-State: AAQBX9cqvAWlkxC1fv7SXf2/HLPlAc15I7L8IBCqotIXGNPXdN73G3rU
        DX3Tv5TCg4IZzP3qrgc3jdhr7nH7ckNg/Yeyt3o=
X-Google-Smtp-Source: AKy350Zef11h8yNPICLFnNZ1km50ABP1QZ5eTwcMvZzsrRKoGT9GpBy77V4azfg+57adg1EWrkNJP62QfEuRkhDuTEk=
X-Received: by 2002:a05:6808:118:b0:38b:5349:e112 with SMTP id
 b24-20020a056808011800b0038b5349e112mr2499244oie.46.1682083648707; Fri, 21
 Apr 2023 06:27:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: lindwilson141@gmail.com
Sender: drrhamasalam8@gmail.com
Received: by 2002:a05:6358:3190:b0:11c:59ec:79b5 with HTTP; Fri, 21 Apr 2023
 06:27:28 -0700 (PDT)
From:   Ms linda wilson <lindwilson141@gmail.com>
Date:   Fri, 21 Apr 2023 06:27:28 -0700
X-Google-Sender-Auth: eoe_cpKaLbmtZJXdBhj88KgibRY
Message-ID: <CALomdBaBiYyb+=tsKZKi4tNosXFeKAq8tB+9jBovui5gWxq5rg@mail.gmail.com>
Subject: MY WARM GREETINGS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dearest Beloved One.
good day how are you, Why I contacted you is because I have a Very
important and urgent
for you, awaiting to hear from you.
Ms Linda Wilson
