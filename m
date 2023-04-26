Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245E6EF3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjDZLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbjDZLxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:53:50 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5759E9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:53:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-504fce3d7fbso10776349a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682509978; x=1685101978;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=G425HQU8+ytvuvA/Pa/64FEEumK8hNS/c4LvJz1Q94YJdHDDpkIvh5TbP6GOXlz6/r
         N1cCs2df+GlYtt4l6JMCvUlPU+ZQEvkOFSw8SmKKWV1WPQGiOgLrpWw2aWaX+uVMCRVr
         XFhExDDE5Xngu6YBFuc+5wlF0ID2S0cI2M+sGUFIynOijsEC0EQymDz1/eYRFe1QJc1Y
         mtZ/LXBOhK25AJp1CrRfdFkCnXXp2UDO1JqKuxQZozTXAA+g1p2QMulY5mmnKQxye82h
         ER9yEQMMOR9a4IHbWRYtojQNijyCEcjXZ+qR2qmNmM5gNS5aex57C/7EiHcFw/sN+Pb9
         Tcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682509978; x=1685101978;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XY4y5vS9eN5bNNtSYkhCEtywGs5g5DuLfZAXtRkyawTprjwSzTtu0u5cRv4s8iDN6c
         8BlAeH0DaGs6xB+O44xQHEiKtP5BWGnWB20nu5osZ6PTT2gPBSlcQpkTgFfYYQsrr/6y
         iAtsEE7ltSlzsY83X4W52hqamSpuO61JPPhbtvE4dnQJVDZ0ah6RgsvC7VkhtRJnM38R
         a4gVBGjriWGdUB13ya3fIz0qr2UMtWFGNJ2jhmRrYVm0fkOktqZf96PP+6cjMuknamQg
         Dy6vohZweR3DxJxdzQPQqUKRWZkoUBvV2vCjR+zjJDGyMH3GIWC2/klKCAqU/5MYF62B
         iLpA==
X-Gm-Message-State: AAQBX9cCco/nWLJYKdkDstLIAEp/sULnjwR1Bnf4cHaRRuUIhpkVXZpf
        RLH0tegM3SKxXUbDzfph3l6xGmc6BSlRS/fIqJQ=
X-Google-Smtp-Source: AKy350Zg3fmLPpLXuHn5IlFbpqQqsODRnw5RAjeaXGHup3e5EErltZ9eeBGNTlw2dM4AFuug/VxNZy0jkH6FhVdYQI0=
X-Received: by 2002:a05:6402:28e:b0:505:337:c537 with SMTP id
 l14-20020a056402028e00b005050337c537mr18151964edv.16.1682509978102; Wed, 26
 Apr 2023 04:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:df93:0:b0:1c6:7fd9:9113 with HTTP; Wed, 26 Apr 2023
 04:52:57 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <daswas250@gmail.com>
Date:   Wed, 26 Apr 2023 04:52:57 -0700
Message-ID: <CAM1W4N4cBdqdrqki_MFhMF0Kt8DbsLbm24m6j5F+H7guP6btEQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
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
