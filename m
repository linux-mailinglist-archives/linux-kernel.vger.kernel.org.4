Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6E6C6E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCWRLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCWRLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:11:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5622031;
        Thu, 23 Mar 2023 10:11:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so2740682pjz.1;
        Thu, 23 Mar 2023 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679591478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk7SEtB9O6XaM6uP+epD7ilSH+AGZvmgcFSg/qKerCI=;
        b=NmeHd9TY+roYM/Oz03gAgRhQpqw9mDk2J/rCkAUwkIPRvr6pA590KPpv/gJ/tcsf0r
         zO5zOAa+CT7U9/5gEnfw5rNV3kXYt796M8eTNCYSXYRk3MJqFjKo4YZHQmd/hSrOg54W
         JEpmfTUn1d5eKmXJN1oyaOcsFi0aJroF3kIvVdxAeE6kX2jRAoTOA5+w6f5tuk8yCiLb
         sLxgleQcvk1IDzNcHI+48fMVnzHyXyUyTaGstu+aWw4L8q+sxiMuq6jtJZasI6vY4HO+
         Owvzyj9x23lsTM8X9uJ+9pET/S2y2HfhZokU5sU3/DhSJSUc2sSHveidQcMcTLiGcAUa
         wLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679591478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk7SEtB9O6XaM6uP+epD7ilSH+AGZvmgcFSg/qKerCI=;
        b=2cMEXaMuL0Gzq7DNWNyfpYF9/QSpQ+bXe8C1nzqBXCQTn716kQggxbGRtp/Jj00kqe
         ucpMN9AOmi15/W+1opOplAK5fWbMDPungVAAwZF88r+QOldj/1ue08Pa7jaUDc1JKULz
         HmTPWl4LffHU3O5TRP3DnXdzhTrI7sAGVDFGaDBrK1pdTdN7K26Y8Kx54wchgrXRLI3B
         dhboTN2Vsm1fOJMRA+eg5yItWD0VKmbcWTZnnWX4OxmfRj92cmnXbfFCCLMNS5bQ9ir5
         1bT7jSy7ABw4u3xjcEKdqNocSvhGWQkZJ5JqvBnX/TYiHw0aIXxk8kOGh6vubOUbcPT9
         /oUQ==
X-Gm-Message-State: AO0yUKVqkkqyk+jvyuEiqgAtbIwOrQHBlpFZygxKo01U5/QdE86Z1Gcf
        nmyk/wFj8WwnBbkyd134VCzHWsrzJVPJVEbJbso=
X-Google-Smtp-Source: AK7set9zYXnWHCU6xqJjbpiCYnTLpN1sKQOZhAruDh4oyjqc2OCxFzrs+aD7PF4vpswXjJtR2sHA2Q==
X-Received: by 2002:a17:902:d1cd:b0:19f:27fd:7cb5 with SMTP id g13-20020a170902d1cd00b0019f27fd7cb5mr5396016plb.10.1679591478507;
        Thu, 23 Mar 2023 10:11:18 -0700 (PDT)
Received: from pavilion.. ([2402:e280:2146:a9a:96dd:65b4:8354:3919])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902a9c400b0019f3da8c2a4sm12557102plr.69.2023.03.23.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:11:18 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: alc5632: Convert to dtschema
Date:   Thu, 23 Mar 2023 22:41:11 +0530
Message-Id: <20230323171111.17393-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
References: <1a2e0f7a-771f-5590-fc54-b9dbf059a925@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is my first time using the Linux Kernel Mailing List. I apologise if I commit any mistakes.

> This should not be subsystem maintainer but someone related to the
> device. It's maintainer or interested contributor. Unless that's the
> case here?

yes it is wrong, he is not the subsystem maintainer. I will send the updated patch.

I have a doubt, for the maintainers list, is it required to include all the names of the subsystem maintainer
in the yaml too? As for this codec, there are 4, shall I include the names of all of them or the one to whom the
module is authored to?

Apologies,

Saalim
