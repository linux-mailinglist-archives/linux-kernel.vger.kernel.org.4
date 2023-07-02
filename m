Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767D744E1F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjGBOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:37:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34EE5E;
        Sun,  2 Jul 2023 07:37:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so933662f8f.3;
        Sun, 02 Jul 2023 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688308658; x=1690900658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i/557JepWvhXYDwLvQtm3WxhtP92izEtjR5vRFBdEE=;
        b=OMjwCoIMtM0NjJfGq2I9INpt/y34b8g9YdC7ObGVmNChFq40qC/QpddkuVtjxb9j3A
         45eyHCBwiQl9VINY7PPOJFMBGtvAolGLNSd4xFBmabJ9nXPo0Ymj+gCN96CdKTZ4w7Hs
         GIgScE0NZ9HsfbZ2Rxpt3jvHfuRHn3yf1MJCfZw4cmpsDxyxaYqSCRIrDP0zaVrZdZnS
         9vb0A1Bto4e3nb+XBDReMTY7dVBTIxyi04Ylmye4Xyv6tbXTdkNguJqpFBj/5Jdg4ieE
         BNcSnUNkA92Fg0xfmX+F848Z0GWvPyhp9NyfeuK9yPv4HCwcl39GdZvfPI+fvAuLqhNF
         Z1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688308658; x=1690900658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1i/557JepWvhXYDwLvQtm3WxhtP92izEtjR5vRFBdEE=;
        b=MxuTB2SgajhxEG55C52OT3QUPNUvDCGIhuifat+p6BliAlcTQTG04BKTUgb00NjKmw
         6i/hw0Ej8SkkNJ8sQETVbLOr+ECIPrPEXgyVoK6bMg2SOb5CSywL7hf02WwAKCCw1PEU
         mn/J81BW9HvMFX2t9+edJ/8OCObPIATFOQP230bgnV0h85EH5BiVTfb75+0RGcddhtAu
         n+AjWpSh66qx+rN6bDEcGJj61Huprt4XNp2fkZjBLxSISS8d9qv1qQPvzDlGOf7vKdNX
         Qk7rDCm+0cA8WcaAe3HY3sf4vvDO7PYpAM9fYP5HLKi/1EKG8Ky3Fy1oa20ZW6gVc9XU
         OQwA==
X-Gm-Message-State: ABy/qLZqOP9unIQsTAHQJI/SgkOr+/xSw5b5RCEVcdXDVmK54kQCTE2K
        wopDM/EsYdHmQmhT/zpIE+1mXkgAcujvpQ==
X-Google-Smtp-Source: APBJJlEBUtr/wKo72kXAHY2LJiSnrLC2l3W0GuXeD9xgWdETIDqHEj6HKavcxiwcFxjdP1qvKJkrRw==
X-Received: by 2002:a5d:45d1:0:b0:311:3fdc:109d with SMTP id b17-20020a5d45d1000000b003113fdc109dmr6265037wrs.1.1688308658077;
        Sun, 02 Jul 2023 07:37:38 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:86f5:6700:2cba:4a71:c713:649b? (2a01cb0586f567002cba4a71c713649b.ipv6.abo.wanadoo.fr. [2a01:cb05:86f5:6700:2cba:4a71:c713:649b])
        by smtp.gmail.com with ESMTPSA id e17-20020a5d5951000000b00313f61889ecsm17123623wri.66.2023.07.02.07.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 07:37:37 -0700 (PDT)
Message-ID: <5b3dd32c-4177-a257-1209-1bfa918cb631@gmail.com>
Date:   Sun, 2 Jul 2023 16:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 1/2] net: dsa: tag_sja1105: fix MAC DA patching from
 meta frames
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-2-vladimir.oltean@nxp.com>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230629141453.1112919-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/2023 4:14 PM, Vladimir Oltean wrote:
> The SJA1105 manual says that at offset 4 into the meta frame payload we
> have "MAC destination byte 2" and at offset 5 we have "MAC destination
> byte 1". These are counted from the LSB, so byte 1 is h_dest[ETH_HLEN-2]
> aka h_dest[4] and byte 2 is h_dest[ETH_HLEN-3] aka h_dest[3].
> 
> The sja1105_meta_unpack() function decodes these the other way around,
> so a frame with MAC DA 01:80:c2:11:22:33 is received by the network
> stack as having 01:80:c2:22:11:33.
> 
> Fixes: e53e18a6fe4d ("net: dsa: sja1105: Receive and decode meta frames")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
