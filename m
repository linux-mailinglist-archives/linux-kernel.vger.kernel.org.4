Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3A728B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFHWbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjFHWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:31:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A32707;
        Thu,  8 Jun 2023 15:31:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso890771b3a.3;
        Thu, 08 Jun 2023 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686263502; x=1688855502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhivM7By3nLdfuN7nIcrMUZQlANFqe/dkrKXW1x6EJg=;
        b=cFoMdMX8ZzS23UbkyLqLYfChq0izci7cIZho3YkXqXF7EtRyy7PQIqApWkj6D6CctU
         oH6FxxtshZkPMlEBaVNDSQ6LdEbtd89Rb7tCt8VC3hy99cJuZejrfOX1NNohclzsAqLw
         0o1uMkpS85ZJjIhjThvaD2eZSBZamWZ1ICBOaGPqdC5NQzWIU2V7uM8znXwHoSXqZMcF
         wlcAZcd8H4b5nsu90IBvsC78Pl6IO9zvMUEU06vZRbfSvJdTYjMGtyDOrH7WAC42/eK3
         6iFg20Gu9b3GRgEFdfOdqTcD4bZECvSeywzDwE7IuqYSbY8dOyMhdwpvk1IJ8RNeV8sE
         XkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686263502; x=1688855502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhivM7By3nLdfuN7nIcrMUZQlANFqe/dkrKXW1x6EJg=;
        b=h+SYNOF9+1bK2JNQxPLpjuWDdKB6lhl0jbNsxAzPB942666g2fiDyTydyH5GxSi3+Q
         /Ovkeev4sWzJDurUiWRIHuFwzW0107gUBmcAL5u79FsLV744qIvxshttTEAGbO4tCPfh
         tBrnDGsoUbYSR9OOIG6FLU8IimGTkHDWv1+4I6WjKaNlJUO6IjZiQ5H8jTesKq91TyOa
         d9YCBLlv3Yv4cw9L8APHrmCk4nhezX9KRHIoa+Aqs7N6QJ5HAjUakngEiqv7nQxpi7VQ
         PZbjb/uaB/V8+RdLOteoAf6ug5SzBhQNb1mnxYE3kT6cZ8lo/4q44vB9As1m5dGN58ON
         CMPQ==
X-Gm-Message-State: AC+VfDwJtV+IFraWdPUykWFLjg3yGuS53sMGx9NzZHY8+9eWHhHLOsCt
        T9aavtYLbz4HRodMrCSsXJM=
X-Google-Smtp-Source: ACHHUZ4L89QNlnSiO+NwEfVrmhnp2UE+ypkGumnnk5OhYo+oOBXWl7nHro+Du4ii9LM3RPIOJ2dwaA==
X-Received: by 2002:a05:6a21:6d84:b0:ff:f3d9:1ada with SMTP id wl4-20020a056a216d8400b000fff3d91adamr6571878pzb.60.1686263501786;
        Thu, 08 Jun 2023 15:31:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a62ed05000000b006580e98326esm464119pfh.42.2023.06.08.15.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 15:31:41 -0700 (PDT)
Message-ID: <e7b68810-e886-c0ca-0a5e-4fa6ac3cd7cd@gmail.com>
Date:   Thu, 8 Jun 2023 15:31:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/6] ARM: dts: bcm28155-ap: use node labels
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1685127525.git.stano.jakubek@gmail.com>
 <cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek@gmail.com>
 <20230608221107.2982587-1-florian.fainelli@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230608221107.2982587-1-florian.fainelli@broadcom.com>
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

On 6/8/23 15:11, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> On Fri, 26 May 2023 21:30:50 +0200, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>> Use node labels instead of nodename@address for BCM28155 AP board
>> to simplify its DTS file.
>>
>> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!

Dropped that one since the kernel test robot reported build failures, 
please fix and resubmit Stanislav, thanks!
-- 
Florian

