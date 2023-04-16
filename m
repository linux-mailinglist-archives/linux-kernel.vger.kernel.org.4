Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0EC6E379F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDPLCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDPLCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:02:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656C26A4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:02:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kt6so18773849ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681642960; x=1684234960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+s/B4eOWujes2P8w0FQ9OyTkSIgsXvTMJtbi4pA4Ms=;
        b=LoJwkKaHZuLQSpe5mfubX2q90+8KP8SJSIbv7eWqc8stVGUcbxKNHGsdxIwqVVTBOr
         wK32WqOXG12XXQ3ASKOSRixBJemSYGKBwZiaFabVcI3T/RVZapqspnvqp8+fVVxh4sf1
         mFqvhaY6XXj3q8+ku3B0es/COgLcTxplSqHsvN0JXOuHsRYhMsz11yU99fejURyty62H
         8E+2X/exTrtzWBnnF+9eKHEK+ENL+Rt8gH5r8d0OzNq3RSgJY1DXayP7e/Ha+3Zs1+5S
         VfJM/jiMhOrnV4W1wdXDRLzLkjj38ElYY6xzpcE/Qa9pNmhCkiftvA2O0Zp1TZt6yl3K
         d1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681642960; x=1684234960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+s/B4eOWujes2P8w0FQ9OyTkSIgsXvTMJtbi4pA4Ms=;
        b=XVz9id+ILlrv0eGqBgeWQ0VtQBa3GWm3ftri6i0WLBeE8EWjKs3Dozl2ljI2jYr6IN
         jfdcrXxni1dtch+YThT3n0+6BF56Ote+o416uVcO5FgL+6i6BbOKQSVcBvZY3PQB/EwD
         vScYeNv15ppEY/yJeosFEAu/VA1c7BWVYwTOguG4f9GXpfHt86ckhVlxXO8Rh4uwaqkX
         sQ36Jb3p9ZzB7BQEHWhK4+I+lZhehxP3lkUCif0kqLafcKZKoJ2UGsCUzxBrdWcpxWx4
         Nf1ECcrDj3ASQVXPlcXPelEm/hvdhQlmRDhWLwmDOXo8NC+jzWCF1Nwlss3VLankhBBJ
         kYbw==
X-Gm-Message-State: AAQBX9fDWVkLsMkmxWP6HeSlEyxMeNOK2dviUCPydjQvpbuN3B5yWP3f
        GiIYQ753DFlhhvjYeQW/f794QQ==
X-Google-Smtp-Source: AKy350YdAKWNPsFVv4cdGqySJKoT8asIrHUdwyGPD1r62LVITFLHykWctNjuzDA9OAUXGziE0T3tng==
X-Received: by 2002:a17:907:6d24:b0:94f:3980:bf87 with SMTP id sa36-20020a1709076d2400b0094f3980bf87mr2622794ejc.43.1681642960178;
        Sun, 16 Apr 2023 04:02:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ry13-20020a1709068d8d00b0094ee3e4c934sm3395556ejc.221.2023.04.16.04.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:02:39 -0700 (PDT)
Message-ID: <34c6632f-8fe0-f8d7-8900-3a9089faa14d@linaro.org>
Date:   Sun, 16 Apr 2023 13:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] MAINTAINERS: Add myself as Samsung S6D7AA0 panel
 driver maintainer
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>, thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230416100139.13741-1-aweber.kernel@gmail.com>
 <20230416100139.13741-4-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416100139.13741-4-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 12:01, Artur Weber wrote:
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Missing commit msg.

Best regards,
Krzysztof

