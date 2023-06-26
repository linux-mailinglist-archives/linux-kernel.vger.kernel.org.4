Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FF73DF63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjFZMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjFZMhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:37:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAEE74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:37:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311394406d0so2785430f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687783045; x=1690375045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmwsUIpLBE8ZW9WxhO/n+Vf0ercOysVYIs9HWLIFUok=;
        b=DFM/f4L4ZEgIz4oGjkPeLb6lMdUgPYYV5i0utdwXjjBaWdVa0aT3TRyKapFNcYwWd8
         16qXy6ByuxHHFDk06bVPvIAoVs/BvPuTjHdilWNn885VLUlo2BPcUNC567pkywi7jhEP
         vAc8atErwBtp7t5p1mRnVht9nGu1JPPwSjVSKJOYBZ1xfWcEhAUhzNvcj2I1TIeHnJ3e
         upb7TGHy+5MFPiYHj9KGj5ckjHJ3ovWym4ZQcvlJDvIfZWhNoliQky6/VeT+esKyFRM8
         0xvAEoTP1PZUvJUbPpTGUBsfW+yuwXNh500s9+VRL35sx4cRlRtjI7q6Z3BjQjQNtiRD
         vYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687783045; x=1690375045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmwsUIpLBE8ZW9WxhO/n+Vf0ercOysVYIs9HWLIFUok=;
        b=VCU10T+8kBCyHjTedREg7pFY85ikeVcZma8FvGLA2LLDAe2hqJ5Ca/+BpJllw6SDl4
         ALpN6foxvnfQLrzNMIEGEe6TYmJ98oTeC0GgB5ANcZmmPiblqt7GHIUCoJScMA0f7suC
         rkexR0IRzXcXukCH1Hm4sltBXhiITWLL9yAbvErbn3kSh8feCrNz3uZIEBLql2gDId7/
         3uuS4+5tZoX/7SIwDIYhniWxo8uSOzyhr80h1lIlqs4F20T4Bl1oxao+LAlrtJkbRU1u
         pkS5AscAi12BGnkKMBhK5oejOYk6B39agTq/11fGenBrbqYq0P5AfULJhRtm0bxc5UV7
         qSiw==
X-Gm-Message-State: AC+VfDxk/JBFU9bCCL5n6w0Vax6z19AD9r1KWhbdzMXKFMMNqWIN9oFc
        FBu55NqzR59yuKYXrCc5+DHkoA==
X-Google-Smtp-Source: ACHHUZ7qic4XTu5L/ba8HgXWQZJaFzSjJKU221HCCWs9DpLcb095jgXrSLFAlmbVCRAnOOhOR7LBeA==
X-Received: by 2002:adf:f5ce:0:b0:313:f676:8343 with SMTP id k14-20020adff5ce000000b00313f6768343mr806827wrp.60.1687783045551;
        Mon, 26 Jun 2023 05:37:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b00313eda9a185sm4209426wrr.87.2023.06.26.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 05:37:25 -0700 (PDT)
Message-ID: <a980885a-3379-9278-2652-1a1b68983709@linaro.org>
Date:   Mon, 26 Jun 2023 14:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] Input: cap11xx - add advanced sensitivity settings
Content-Language: en-US
To:     Jiri Valek - 2N <jiriv@axis.com>,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
References: <20230626113740.809871-1-jiriv@axis.com>
 <20230626113740.809871-3-jiriv@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626113740.809871-3-jiriv@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 13:37, Jiri Valek - 2N wrote:
> Add support for advanced sensitivity settings that allows more precise
> tunig of touch buttons. Input-treshold allows to set the sensitivity for
> each channel separately. Also add signal guard feature for CAP129x chips.
> 
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

NAK. Stop adding fake entries.

Best regards,
Krzysztof

