Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CC63A302
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiK1I36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiK1I3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:29:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8961181D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:29:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o5so6510422wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IOpIkVTZ1HCSepxMCiPIVLc3Du6eeySPU1lvrDaAkA0=;
        b=iP2YYiwl9QvU5Fj9JzDa1Ner+PSjuXkcCMEmS9tW23BnczYppbVvnJU9HQsJRJDFNS
         HZGopcus13C3caspnBXrNSgkN7Ofp4VoMRbERqTmkFgkdmRtkTLT6WoY7RMoq/jRUGCv
         vLXOswkWlJEKu1Hyy0pOgM4fW9NcyhRx/KCsxN9lehS7MgaxFxnjENjvvO1kv/WI2S9d
         k+q36KaGkqU7wTycEHYnKklfdJNfqs5rXFwBvKF9R2aa+qcM7CxT+KZAjTHmr/sD9S25
         tE6J9yWHEhkDhFeHXd5X3qJCiBLzVZW2PI/+Ma07Rz8x6BR/OgIeJ1Hp4kPTGRy0NY0p
         0bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOpIkVTZ1HCSepxMCiPIVLc3Du6eeySPU1lvrDaAkA0=;
        b=qmkJH0qZ4VFuEaUId29UoDlAKdtsOLI3L0sG/5TaCww7uGWRHSYLdbBt4/cZl+Xi6s
         H8TYZSAkFmkXJgivUxrP6CHzJ/X113fQMhAUO9achm5i562LkMfmgR2ilWMUZN09myxB
         ghnkfcnuhvce5Ou503D69PCtVLrq8Xjh6eG1Y6fTG+7DTx+D3Upp5O9yRus+o+ZxLyDD
         CRRGqzog4U22olL/rLYOTUJL2Kyp1FBpnHM38bx9YNhyeg8jQzddMRt0eToCPpUYgsLu
         Ul75V1T5/xjpZabm1+7lDHdnjt1eon4II5qAo0aKzXRefVdwwcdf/6lBwoEyd/sGNV/G
         ID2Q==
X-Gm-Message-State: ANoB5pkQLUfhii8OncQAexFx+c9jsFpYjV2SvDKR8yqh+lZ++io3GSBd
        0B2G89a1sF1+pB9xJ9P+HfY=
X-Google-Smtp-Source: AA0mqf5o3omyFNxLGgAAlS7h9m5pGaApcXCeWfag+9dMe/kyf/xcUF+n/HOzhL9shN+Mov9HNNGpdg==
X-Received: by 2002:adf:d0c2:0:b0:242:a37:7abf with SMTP id z2-20020adfd0c2000000b002420a377abfmr7101743wrh.190.1669624182677;
        Mon, 28 Nov 2022 00:29:42 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:78ad:176c:d7ef:5797? ([2a0e:41a:894f:0:78ad:176c:d7ef:5797])
        by smtp.gmail.com with ESMTPSA id i17-20020adfe491000000b0022da3977ec5sm10020436wrm.113.2022.11.28.00.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:29:42 -0800 (PST)
Sender: Carlo Caione <carlo.caione@gmail.com>
From:   Carlo Caione <carlo@caione.org>
X-Google-Original-From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <a896ab20-6a08-fc41-ff2b-250ef477d801@baylibre.com>
Date:   Mon, 28 Nov 2022 09:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/2] Make ILI9486 driver working with 16-bits SPI
 controllers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 10:42, Carlo Caione wrote:
> This patchset is trying to fix problems seen on S905X boards when interfacing
> with an ILI9486 equipped SPI panel.

Gentle ping on this 2-patch set.

Cheers,

--
Carlo Caione

