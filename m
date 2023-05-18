Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1064E707CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjERJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjERJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:28:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF382137
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:28:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965e93f915aso338352466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684402129; x=1686994129;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=gtnjKTyXOLSsKou+ZtT7Js3k0ABaZ2q/Vdv0ZoHT8Ndld7DDKF9uphJsozKbGnGUJj
         IkTSvev6rVN6QqyST/ZAU1gYqJaKESj2ZwV9Z3K7ekII6TsPWYBKnbEm5HOuRDVhcjfx
         8lL/heGhG0PytscwaOuqsFcY5tvez/3hpAsWjA0zrA4zqMaqaVOZVbaTfTrxKrhIrrKq
         MBwkLMqQtLovPfWBCrKe9fQT/+AhRH2WaPNEGb1piJBwYWEJAM2ftwojIK3QG6lcUIqy
         /aSVhL+FoUR3z5cw0q6x/wjG5lAVyOJFlO60iv4mr43N+SBZh91zl1EkD7cXkPaXW7mI
         Z9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402129; x=1686994129;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYlqmqzmZQIzuckqyml+D+cUQfB/LAmhyfGQVjeCZAE=;
        b=CdmJ26fGq52BVFn4X/k50mwVJCV4JRSbzWVZE8F2+c9p5xYVH5fm4ofNqOI9ABAbiQ
         xSfmoWn9/1EHF9XGzsVDIo5u/SbB7q+wLcQ2MthULlbQFltN0p+jiKjMY91P8Z8/A+Y9
         /8lfWO29A39I6YSLtNDVWng3MRteq1lQpMxUv/4n2yWkDPOqX1sifn5MYuEcom24uppA
         42yvzxQy7Snv5S6B0wZHubz6ELT2eGESXjeQK4t91qNy/98MHvw4Z36hpYkKFOM/bbaQ
         CGDZSjJo8ehiIXK6MtOKyUdHZQMn0lxnF7K/L5Lb52bMeoMCSy5RcFyLFVe+U2703ldm
         DTAw==
X-Gm-Message-State: AC+VfDymLyuyaRj9523ITdbxS/4/KLTC39TmZyfipX2l6f7CL7BFuzzP
        Pap6MZNMl6ztAuD6FQhF+yoyzHuWrPGwhWIKxZo=
X-Google-Smtp-Source: ACHHUZ6JLscwQclVvra+JH6DMsgNjrn1UYPFDeRU8pBIIiAI1n2oIqURpqQB8ZWxOFbgZqjPHiObNACk6qnSQNiIH+Y=
X-Received: by 2002:a17:907:9347:b0:94f:322d:909c with SMTP id
 bv7-20020a170907934700b0094f322d909cmr36760051ejc.34.1684402128402; Thu, 18
 May 2023 02:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:dace:b0:94a:7e28:ef2d with HTTP; Thu, 18 May 2023
 02:28:47 -0700 (PDT)
Reply-To: ninacoulibaly03@myself.com
From:   nina coulibaly <ninacoulibaly013@gmail.com>
Date:   Thu, 18 May 2023 02:28:47 -0700
Message-ID: <CAHS6EwX4OfwndFTCJNwNVSd_qkh309YmPxpfxe4_FPHuA+u3OQ@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Nina Coulibaly
