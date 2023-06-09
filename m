Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F2C72941B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbjFIJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbjFIJEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:04:49 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2761FEB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:04:25 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55b619e0ed1so57904eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686301464; x=1688893464;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POzqMJPnZ8n/AxRgRpXufq5bH3zdXADjXwcrF1+uW7Q=;
        b=dDtE49Tf1186ncv/8Ubyq2ihAZDRvn40MlpIHWiQPWaB1/F4iNA4Rfu1TJBHVT3c5K
         8zFc1l5QuIEN1b7MCCIQ6XJqzwSsO/41+psRnV3l75rHTgsB+iHd2wUyxj1/JicsvUxi
         C3h8+ovkGqwGI78nGKSzAKBnWIj+AXgZXJO4iatmbYOyivo2ONIvxq49qyiiM9yeUkg4
         H71W0KEAixliKBeQwbBcT5pe2ZG0BvxyK0206dMYn+0SFFA3lw+sIyx4TG4RVAGYPwoS
         TWdvEyujAMpYkmoTAWLu1zdkYcfa/7fl8bCDTK70mbL05hu1ee+5pjVO5lFz8Nai7NGL
         quEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301464; x=1688893464;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POzqMJPnZ8n/AxRgRpXufq5bH3zdXADjXwcrF1+uW7Q=;
        b=fjIEqpTmTnuSyqRZL2C5HUm4HfV6LxpvMQbt3YD/dkpCVME/p+yzvQIR31c6We7JDp
         UoYkZdAbatr/AYr3bn1T9VqvKFVVIQg4jsOY0404Jb5BPkOEyrcLsIEPaRSB6BrIQMCT
         QW+aK+DOgB+kBrLsVowF6+gNKU1MdtWRQi93I/yKWjRloNPtplN3EtIE44oruDtKTfPC
         DQkZ3gprx/zDpBkJwy8/XS5gLWd63BqNML1r7J/Mg4pBlSVYBaEqBW4pDDPK9bCRWF7y
         BId84GqKSuR2iyi6XsuFlGSJbGgyXteXbTakbQD/ZilFS7WkgRRdp6JMXoIed8m1vats
         71Lw==
X-Gm-Message-State: AC+VfDzOMXUzr5TaW5ggP8PWf+IPZ2EI2zQ2nIHQ2PDGMBUV4ha4m9As
        pu1Zv1D9H9V6f7CNeVXFiJyt0ZgIbipdtTAHuQQ=
X-Google-Smtp-Source: ACHHUZ6AjFBr6C8/8oY83VC3ozeqvk5BsvAvsEMupQyeW3T/Hyxyi4yobkJEi/M7XzAn75G2MN+Ll7MoS6z3j6RrHHg=
X-Received: by 2002:a4a:d08a:0:b0:558:b5c7:4832 with SMTP id
 i10-20020a4ad08a000000b00558b5c74832mr421491oor.3.1686301464445; Fri, 09 Jun
 2023 02:04:24 -0700 (PDT)
MIME-Version: 1.0
Sender: koussistella435@gmail.com
Received: by 2002:a05:6851:828:b0:4b0:41b3:fda2 with HTTP; Fri, 9 Jun 2023
 02:04:24 -0700 (PDT)
From:   United Nation compensation <turkey.un.info@gmail.com>
Date:   Fri, 9 Jun 2023 02:04:24 -0700
X-Google-Sender-Auth: EWgorKskTRRvybvpJj4IO8q2ji0
Message-ID: <CADtNC_ct8U8E0A0YgMFLcMTBA8fyosjrkcpSzLfMaRzeYsVtQA@mail.gmail.com>
Subject: United Nation Compensation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friend, my name is Mr. Kenny Frank. from United Nations
 kindly get back to us as soon as possible
official Email:(turkey.un.info@gmail.com)
