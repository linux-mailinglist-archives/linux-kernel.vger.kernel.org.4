Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D962CF27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiKPXyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKPXyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:54:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DD60372;
        Wed, 16 Nov 2022 15:54:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m14so173331pji.0;
        Wed, 16 Nov 2022 15:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5z7ys663MeP0GSbt1WvE0axWW5OCrIne8ubKgJMs6o=;
        b=Ue7qUM8TskaHypq2797mnWQRE4HCLvFAH5Wu357sRJH+hYxVGcnUubike2KoxTYRMR
         HtlUrR+1tugdPtcsPOWPvRGuH2Iolae3ss4TLc7ZwOSx+wjZBj71ZsndfjImnFL4l4cJ
         sU7IYh7mcCD73iJqRAOeFHX00jzfjNRLlvBM3+TyA/UgvJuGWquSxgX0GwrEIpQIyz2n
         RKiI569ZRP2tw+2iNME9WkyTZbHVwFNEMexzrYgIWtH8ByeNsOiXhffTRRUHERBnuNe9
         i5ADAKpQrsxKrCpT0oXTMdvoLMl5L6wDmzj4fkG/GZq64hoh/1xA0lx9N8Wgs971yku4
         ZLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5z7ys663MeP0GSbt1WvE0axWW5OCrIne8ubKgJMs6o=;
        b=bwj4Rtj+KJhxoaKisHkUMQ4+Eyn84fjM42MPgqRN4/yMYT7YAzbSZdg8LnAgeV8xbf
         kjsJcVFHgzSeTabGzfRWfymItNsZ3MS3wGZB9VQDhykmjT5Eeet5ekKIZ8pvlUwYf+QN
         soy3i4/+lmahRvvURVNMEWI5HPfGIhp+/Fcafca3P3YaImCKFRwQSr1KFPdjGRn982DQ
         LlYoS9xFIBV7dvVnYHUuLtbAZa1sVuVotAcXtP3b9jib7LDEZxB3k4yYFoaR39BUXfIy
         Gw1kQqt6u5IeXnth6vi78gtVTz9OjO3wEE0Qk5ibUGF0RLXWVEbQiSCo5usulcHpnc/G
         eukg==
X-Gm-Message-State: ANoB5plkjcEBYY8sAEAfVAyFxEYUJxOdciIum4RUPFwhVwG+OcijC/9o
        CyiluoAJRP51YVj1q6MYN1Y=
X-Google-Smtp-Source: AA0mqf6DskLM1fhE1mgqpdNo6T1Xr28WOtupBX0ZR9a6O8lun5tyl7wHRJL4E49dyynG00oF28elCQ==
X-Received: by 2002:a17:90a:880f:b0:212:e996:704a with SMTP id s15-20020a17090a880f00b00212e996704amr5974544pjn.13.1668642884141;
        Wed, 16 Nov 2022 15:54:44 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb51:2ecd:7287:8649])
        by smtp.gmail.com with ESMTPSA id o38-20020a634e66000000b004639c772878sm10371832pgl.48.2022.11.16.15.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:54:43 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:54:40 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, w.david0@protonmail.com,
        stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: input: touchscreen: msg2638:
 Document keys support
Message-ID: <Y3V4QFVPPB/Liut1@google.com>
References: <20221116211622.2155747-1-vincent.knecht@mailoo.org>
 <20221116211622.2155747-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116211622.2155747-2-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:16:16PM +0100, Vincent Knecht wrote:
> Document optional linux,keycodes support.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
