Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B98674533
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjASVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjASVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:43:34 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CEA502A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:32:01 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id d62so4316058ybh.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKQk9nowERhLzd/Vy4NQPgN5VFL7wDftfUE/OhOCZTc=;
        b=YBDmsUlH4GsLjjBcVXCr7sLPszB/R+EtWR+SKoRtYyM6vErTRczUol2G7oP0AGC8fR
         Q3m0l4mQ1aYaCoEaurRc02OwAgEzl/4zqIIfxMvR5E92f9IH+r8oPR0Yo6iaPPSdIDHg
         VnnY0JQcVNC8sScLxLR1GOMt+epBbjq4C07NRtkMStAk284GFRwAZlueIOcBxqxXsAHc
         CGTf7WKysEAFobu1Is8ChyeHf0JwkcwAKAPVfsaQdqKXn02pzdcjaAIfZJj3FEbnXuTU
         BBbK7IB29uB58Z07QZRiLYPKjKzr8y2hNzzEOh/CMvKv0ojCEwdQ6ECZENUtozrBJ3Dr
         lrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKQk9nowERhLzd/Vy4NQPgN5VFL7wDftfUE/OhOCZTc=;
        b=ZX/6JQ9QO3BGt8Ke4nP02lK5MxNQGeacalwM0JVnWudmYgoSERjFCT4QBlorpP6eea
         479j/2zXJM5guCrvk+yj5ONCwU5IZkFdoh03rX1EEI9dKQ7G8laQwul7jX4NOlP+60sk
         8UGETEP4KG/W7bgd923t+2Ws8BlaKgG6fFmOC59IARN2cpB8zevdhDMzR4/XQqmaByAm
         +t7wvUPbLGpXAD81mEVXu1YA0JUAS14Aci6FF0+WbRvOOVHYtAFu2SMKYjixvFBfctPl
         QTeSjPxIUAp0hqM5kKtVBbQDIoylVWRTG420AjFIdTpolkBrCghPgzUokfRJTUT2SnzF
         ambA==
X-Gm-Message-State: AFqh2krFu1Hdf+jBrLBSFj1U7/P8s7PtZ3hw93pZjCJ0E6duEmOEkj0X
        8afvYrdNFPWyUNON4F04mAHpDHPqN2HduQgG4RM=
X-Google-Smtp-Source: AMrXdXugQ6esxyjpSfTrfvRrLbK/EQEVqoyFdbYAvS8DflZmQZcmGvWlC+V4ZR45HxSOnzB+f1DRLJjxa8yD9nnbAXE=
X-Received: by 2002:a25:148b:0:b0:7d3:5998:e627 with SMTP id
 133-20020a25148b000000b007d35998e627mr1509382ybu.161.1674163917045; Thu, 19
 Jan 2023 13:31:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:3521:b0:418:24ef:5fef with HTTP; Thu, 19 Jan 2023
 13:31:56 -0800 (PST)
Reply-To: mrs.lorencegonzalez03@yahoo.com
From:   "Mrs.lorence gonzalez" <solankidivyesh123456789@gmail.com>
Date:   Thu, 19 Jan 2023 13:31:56 -0800
Message-ID: <CAK_f_JY_tm+Bvc3wwXyZq_F2gYOhrz9R4b2q=DeoMqGbA+RiPg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how
dealing with Gold Exportation. I Am from Us California
I have a charitable and unfufilment

project that am about to handover to you, if you are interested please
Reply, hope to hear from you.

Please Reply Me with my private Email for Faster Communication

mrs.lorencegonzalez03@yahoo.com

From  Mrs.lorence Gonzalez
