Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747335E76C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiIWJW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiIWJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:22:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87228E109C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:22:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c7so13921149ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tVjLFplbBUiEp5HH1xJDwTfmDuHqlB39r1xUDOtGabU=;
        b=Y8san3QYDUvR9D+NQ6JCA9bmyy6Tbh8zbuZePV4pZUNzvFh2gO3ecCZUOMLrYzII5N
         6b6IcLVkYgEE1GxmuvKeQtLQqrhnJUhMnBgwTWyPJJbgHClNh9uPljM+UbnBAipSM0IA
         Jq3GVEuYjYPLz+CnIl1x8Eo9UuX4BkNbnPqFjrF4XY3un/JDuwpM+t2cpq+Lvz0B1UeO
         FhtCnV0ChpXjcg59/SQYJ/mt8KL9QqKbj6cL5GLqnTpOVwNMfALG1qhtolcIZ9mXVQR1
         MdUkq2ShxKItCvGPVDuw3aSwL3rMZX2n9r+/q9syQVFti2bBD0wxPAGwRWwc1y/3leaF
         7t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tVjLFplbBUiEp5HH1xJDwTfmDuHqlB39r1xUDOtGabU=;
        b=De1ToJ0kgQ7PTT69aQRX7lssqf+b67unB5Hc5ye3/x5iCtL2d/C4pWjMhiAw+HLwGh
         PqZ4/h51hwTeur8qz+a50UIt/otgw4cuKPZVzW85hL842WhY2dxq59SwPSGx4YZKpqMf
         R5IUaHXYtJGIwpUXWHgSzfyhGN39ZoEnoSnP+jq6b1rvhZPd2Hu8hOXvlnMw+HqclXWp
         LVBC7DM9znwMDjh+1AnP/gE/BkS3e6S0jT40ZiWnV5ZlDZCxVQxJYI3kZhmlTSJ1gTMj
         JZTmxjo7KNLMTZBkMvyaAgetm7DUKjK9lSugkeif4T2mYlUKOPulyPcTpLb9LKCUZLHj
         0I4w==
X-Gm-Message-State: ACrzQf1maAsTYuxmU+v9pJj69MB5RBHOhZ66QjF/BlKxB66SSw0FCVHy
        38r9jrNLCTzkU0eSTd/AC5fqHA==
X-Google-Smtp-Source: AMsMyM5HLwPGkCJxWrNQhy2JrlnzWp+jyVuXDaUzUX25l1BZcCTJtQJ6d59FKXlMOMBXV6Mx+FwOeg==
X-Received: by 2002:a05:651c:555:b0:26c:6a30:770 with SMTP id q21-20020a05651c055500b0026c6a300770mr2637893ljp.376.1663924941888;
        Fri, 23 Sep 2022 02:22:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v14-20020a2ea44e000000b0026c4374a2a4sm1287230ljn.139.2022.09.23.02.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:22:21 -0700 (PDT)
Message-ID: <a127333d-cd25-4fa3-a12d-9c3cda05582f@linaro.org>
Date:   Fri, 23 Sep 2022 11:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     "Mehta, Piyush" <piyush.mehta@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
 <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
 <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
 <MN2PR12MB4333EBFADEDD7DB623F4634188519@MN2PR12MB4333.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR12MB4333EBFADEDD7DB623F4634188519@MN2PR12MB4333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 06:38, Mehta, Piyush wrote:
>> Thanks,
>> Michal
> 
> Enabling wakeup in zynqMp we need to put the core into hibernation, as versal don't have hibernation concept, but we require interrupt for wakeup.
> We have a versal platform where we are not using hibernation, but system wake up we need the interrupt. For this interrupt-name enum would be:
> - enum [host, peripheral, otg, usb-wakeup]
> 
> zynqMp :
> - enum [host, peripheral, otg, hiber]
> 
> Versal:
> - enum [host, peripheral, otg, usb-wakeup]

That's a different name you use now...

Best regards,
Krzysztof

