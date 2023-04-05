Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EE6D7EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjDEOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbjDEOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:10:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA961AC;
        Wed,  5 Apr 2023 07:09:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h3so8313258qtu.1;
        Wed, 05 Apr 2023 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrUuGPcgbacoPaDZwUjyClDlHEdWcnLP/BwbE2VGngk=;
        b=eyXfXYkxZIF6WKWjnHGB/7kYrtZYblTpxPNBHoF4z7YaK/SPvpFdGdEftr2WgEeycz
         LLaFjTCIalR2qcNn16UFiGvgrneXXoezYhLhSsqnsRjZcoZ3lbsQOSR9FDjU9ulgRk5Q
         HvIkQuFyiEiqV6B8Hq8SuoPwXkAi2y0V2uGe68zArMEnQlxISuuofXPy4dF9oJmKE0iO
         ivvr8VxlpDxkEsb4oQmSHG+lPmkkr1iY0tQNAA6B1ibBkx9eDjKUvLkQYJCg3SqYA+oL
         WKjCYv3uWExJsX3MaPA2hHm8TDLFqAZLPjP5GMpKx5Uepe+wZPjRMMPC0Scc2VJND1o3
         cJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrUuGPcgbacoPaDZwUjyClDlHEdWcnLP/BwbE2VGngk=;
        b=wyoXQZjCCxg6mzyerCNwPL6wjzxd5oKULL2x0aAfNmcFxtihV3kEJr2mlUVDL8QB/P
         Jw5YrzeginKMdC8RMbvW+AhwfLviZGH1aL2mgWTudnJfPqFlBqQOx1/phKy5AM5bMYO/
         PU2VZi/gNBzAxa3Mnhlu4YI5IQRjRRhhPBUuFNwyQNx3FmxGeMF3y7BS8GOw0Y7NKLXF
         +cogNnvfx6avWb7BlCGeqvBqnIxDCsqmJuW4uhq7OytjYBbLBAnqy5hlgrp8CJ8GemCz
         rKdLFDy+rr+rcTHQE50zvHcFvElTfxXglJQnBD6BqmQae518cfM9if+1wYtzcZosmjlT
         1stw==
X-Gm-Message-State: AAQBX9dsUYl6EQ5DdCFj+i76uPluQS5O9Z+g15vP1pj+xoCK56yt68gw
        LHbz2S0ailDPeqA2SrXNDZ8=
X-Google-Smtp-Source: AKy350awZP/g5lomgosNmOrdkY5UjqeeVLeO4HAp2z8KiQlvc+5Uu7MzzzJ0mpKTXEwQ9X/miBikIQ==
X-Received: by 2002:a05:622a:5cf:b0:3bf:e13e:30d2 with SMTP id d15-20020a05622a05cf00b003bfe13e30d2mr4211910qtb.67.1680703758548;
        Wed, 05 Apr 2023 07:09:18 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b19-20020ac86bd3000000b003bfc355c3a6sm4023924qtt.80.2023.04.05.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:09:18 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     broonie@kernel.org
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, robh+dt@kernel.org,
        stwiss.opensource@diasemi.com, support.opensource@diasemi.com
Subject: Re: [PATCH v2 2/3] regulator: da9063: implement basic XVP setter
Date:   Wed,  5 Apr 2023 16:08:29 +0200
Message-Id: <20230405140829.602413-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <35202b81-abd6-4e0b-b2ad-a385cbb3979d@sirena.org.uk>
References: <35202b81-abd6-4e0b-b2ad-a385cbb3979d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the feedback!

On Wed, 5 Apr 2023 at 12:52, Mark Brown <broonie@kernel.org> wrote:
> I have no idea what a "basic XVP setter" is and this isn't super
> enlightening.  Is VP supposed to mean voltage protection or something?

Yes, but basically this series handles just the monitoring part. The
"protection part" is happening in hardware (at least on our board). So I will
reword "XVP" to "voltage monitoring" in the next version.

> I'm not sure that a user is going to figure out that this refers to the
> protection levels, there's no hint as to what the X might be and the error
> suggests that both the under and over voltage protection limits must be have
> the same value, not just both be provided.

I will split up the "catch-all" into an error per severity, like:
"error-microvolt: value must be equal for uv and ov!"

I will also ensure that there is only one severity set per regulator.
Additionally, will also adapt the docu: if the voltage monitor should be
changed, uv and ov must be set to the same severity and value.
