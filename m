Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9183E619864
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKDNqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKDNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:46:14 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832FE2F03B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:46:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l15so3029358qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNOoeyNPbk4klwxXRT+oWl+4JUP2MxkRrYLhtJXAbr8=;
        b=y5cyYq+ECxL6vl+kFY5grLw7dVgw/6YPqpqGm2pcr/O2va4IkgEIltfaC/1BQNhGCc
         5ns0noh2pnxhErcjx3BxpvpCdxpNsfKRsKnR5zz4HUkAmuV5Rg19f710w9L09LFzKec9
         r66nTrlfIBjRASVkCbiMJqPJ6u7fG0njn2PlFBnhxiMdG4Chuskz6flV1oYPCYXtVrGz
         XP/JHucGnGIoZu93Xif8VxKCEWeCBZyIIiFTjUxsozZM4w9xQB2J+43w0eX/vwWNNASp
         bL/7TcRZ00gPunemlpJP/K23L2MhR2cCV0uQ4oKeaDPBZmf2jV1LPZs20seYxmi+HcoW
         6nIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNOoeyNPbk4klwxXRT+oWl+4JUP2MxkRrYLhtJXAbr8=;
        b=xzIOURVl7FQhzdoYk4d9i7gsL9+likxRf2Ke3iRmzCPASOaAxVPh3gMI1ahNG7Dnhu
         +H5o6G00cclGCPpaO5D8+oAURur17MTZm3k8+sQ6rlPbxvyLLn8Gul1ZkLTVCPMhU9jZ
         baeR+i0yS+kygd7oI9U5YCZ8yH+4FbY7WkjV7a0r2271Meb8X5zW8/pPUDm9LrMHPr45
         FL+RLcFj3O54tyA2PDQVnzsn4+ieOAzYMl8qj6zZCncSUoPN5bSGjbQ77UJGJUARbM1I
         eEoXR/aF7D7vR9mUUd5tG8So4F+DGevou7e6MGW73Ip8Uc7qGJHRfZ/CxSFbTIq6fn/E
         vPKA==
X-Gm-Message-State: ACrzQf0CjyKRumbY0zHO/iAWhkBTtBXXa0RHhUvVHxY/PNMZ9MQNO+mW
        o17E7OlJgfm75FY4G04IbFZuFA==
X-Google-Smtp-Source: AMsMyM5z68VJ4ZL4fh0QWV5cz9FsjGkFdAAv2iMVmsPyBZltry4swkjwL6vej368Hj6i1GkOsBsxUA==
X-Received: by 2002:ac8:4a0a:0:b0:3a5:33cf:c1d2 with SMTP id x10-20020ac84a0a000000b003a533cfc1d2mr18416625qtq.548.1667569569695;
        Fri, 04 Nov 2022 06:46:09 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05620a318b00b006eeca296c00sm2851191qkb.104.2022.11.04.06.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:46:08 -0700 (PDT)
Message-ID: <9a6032c9-7784-3f64-fbaa-c18982d25a2d@linaro.org>
Date:   Fri, 4 Nov 2022 09:46:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [v2 09/10] dts-bindings: phy: Add Cadence HDP-TX HDMI PHY
 bindings
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, kishon@ti.com,
        vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, tzimmermann@suse.de, lyude@redhat.com,
        javierm@redhat.com, ville.syrjala@linux.intel.com,
        sam@ravnborg.org, jani.nikula@intel.com, maxime@cerno.tech,
        penguin-kernel@I-love.SAKURA.ne.jp, p.yadav@ti.com,
        oliver.brown@nxp.com
References: <cover.1667463263.git.Sandor.yu@nxp.com>
 <f1a558c1511f310475002ed7a18d4e0406318b63.1667463263.git.Sandor.yu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f1a558c1511f310475002ed7a18d4e0406318b63.1667463263.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 02:44, Sandor Yu wrote:
> Add bindings for Cadence HDP-TX HDMI PHY.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/phy-cadence-hdptx-hdmi.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-hdptx-hdmi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-hdptx-hdmi.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-hdptx-hdmi.yaml
> new file mode 100644
> index 000000000000..edd7bf1c8920
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-hdptx-hdmi.yaml

Same comments apply as for other bindings (also phy)

Best regards,
Krzysztof

