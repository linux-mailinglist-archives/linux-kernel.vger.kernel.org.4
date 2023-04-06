Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B66D91CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjDFIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjDFIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:38:31 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD3A6A44;
        Thu,  6 Apr 2023 01:38:29 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id nc3so10636003qvb.1;
        Thu, 06 Apr 2023 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680770308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgLkM+XMzX5W0SCXisvAIqPyvozqS+NmIylofb7Nx5k=;
        b=cjoTOmGHtueyMhleaWLpZ6yOl26OgXkgHfvIdJEgkiVQHAmoqY+PdE2+XdJlM+LTws
         5byaQ1TUTpRdBUE4BLMg0Z0KymjfkKCzosWUpwHgawwLo5/X+wFgdGpyd+zX15Cw2Rc2
         cqnjBxnMfpU22XLnJAOl8uSJZ3T5dHmMOVCV+6/sgwIO6lYICAC3wHxMuhtlSZVPlds0
         gvsP4povDsuL9OUdIMVgAPZ6SPPOAO4vk+2P5PIj7oiyCCo+x2Tfz0ZKfHtAL29mpE4x
         4rtyjowivTLYy03l0I9E+Sbb2eRZf1stt3y7/GwAhjQj7VfetTkgHFgJAGCm5Zi6jdKG
         tQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgLkM+XMzX5W0SCXisvAIqPyvozqS+NmIylofb7Nx5k=;
        b=r29DI17H/JENH8gLebUZUsiodMAZNyXJWH9wrwHlUgSwJAnBIwPqgr+L1NaJZ0ESQB
         yUQ6KDPZCDuhurvv4FxFn6PHtBcvKVqps+SMokH2gpNCEXAhbE0Lxtxp4sZpnS2aZ0l+
         MMjnlmOwMumO/c6NtosUhTWuc7dG+nQMbiYl7RXOPgRgSFuM3+wlgXcy4SiqtUYwMezz
         RIXDygNvdF8JIaITjvW+vUtQiOm/ERhbLvyZEd9A4Xy/H3P+8Cq+44mn+xm92qIM7dWr
         ykaN7R8g7pSDQefOOEU3/B9SeEGWWoU4DUKgnXoF0mqFu0Bw/qP56cYSxLALroGTOsb5
         Fb1w==
X-Gm-Message-State: AAQBX9fsUB5Bu61M+XbOQkm2s+rUvIhemdNVU+YStjbA9IzbrOCAjs11
        cgX46Ag1yfX7C0TV4ozqCiA=
X-Google-Smtp-Source: AKy350bCgxgOUO1gIv445c/wtwiK7hMDODQpFG+zD9OpZC27fnl6fsNJWVgsdKhnGsIeA6fFhkyevw==
X-Received: by 2002:ad4:5dca:0:b0:5a6:1571:1eb with SMTP id m10-20020ad45dca000000b005a6157101ebmr3091570qvh.27.1680770308105;
        Thu, 06 Apr 2023 01:38:28 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id my7-20020a0562142e4700b005dd8b9345adsm349733qvb.69.2023.04.06.01.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:38:27 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com, bbara93@gmail.com,
        benjamin.bara@skidata.com, broonie@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        mazziesaccount@gmail.com, robh+dt@kernel.org,
        stwiss.opensource@diasemi.com, support.opensource@diasemi.com
Subject: Re: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage monitoring
Date:   Thu,  6 Apr 2023 10:38:12 +0200
Message-Id: <20230406083812.887582-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d7e795b8-6c36-70c5-73e4-ae115cac32a9@linaro.org>
References: <d7e795b8-6c36-70c5-73e4-ae115cac32a9@linaro.org>
MIME-Version: 1.0
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

On Thu, 6 Apr 2023 at 10:28, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> It looks like you received a tag and forgot to add it.
> If a tag was not added on purpose, please state why and what changed.

I slightly modified the description:
Basically clarified that both, uv and ov, must be set to the same severity and
value. I guess that wasn't very clear before.

I mentioned the change in the cover letter. Maybe I should have added it here
too, sorry for that.

Best regards,
Benjamin
