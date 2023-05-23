Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED6570CF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjEWAkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbjEWAbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:31:02 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13DEE66
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:22:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-76c56d0e265so38721939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684801372; x=1687393372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDrPFB7cCQge/xsQrtC99WHAQKaVmSUwNIX8SNPBsTY=;
        b=esGuiS1F6Qx8FaANbYrjs5R7eDPydPhGIWU3FV8BvrecKb+wVBaiw4pC+BdOUupp6J
         eO3WFrESYiuXDCEB0i2b3j1IK5DocXlNzqcoS9yK7KuvLU3XfCC6R8xRVGKXVQGPY4co
         OuT4xvwv3+eVmaLFd/z5Lf8bIKYLA16iNwEbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684801372; x=1687393372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDrPFB7cCQge/xsQrtC99WHAQKaVmSUwNIX8SNPBsTY=;
        b=FJ0djEzjwyIdCxnGLpxMMIbBPh+Fp6AH4udskvxp5jwOz5L02fksn8rgIQIJPxdWPP
         Z1EVFKkcI9YrX5UTZRRNVCfN4mXDJdZaXtdj8t4iw80pRUISxajQfMiY/q6DNl70Lvsl
         HxsiUUNi/IgV1eS7Me7yctkb4utWH7weJ4VbuOll2oBo5GVrNBNI+amrHCfuNHU13+ab
         LePmpnCipakeNqIZdQtEl1tx5GGPaEk+ETS52+SfuCzl3fKtr1m65Ah6E6rULRvCO+Iy
         4lifEQ5PsRqnVucj+PZMUFjJtf9JosWPkM7G6/BEwIj6VTxwK9zui2GPVsSIEfO5Q8cw
         8DEw==
X-Gm-Message-State: AC+VfDzNrlXtFhcs2J+XGqodzc5b8FhjQNheLOEEzpYBNo+TszE/xBOH
        j0EgfbS2H3iPk372dGJiXWNfqg==
X-Google-Smtp-Source: ACHHUZ4v+BfxyYUBkyFFh4IJ1Vqv2gi6rw9PcXY16lQ0rZibbfAq6y+X/Da1ZMfAh5GVwE3XfJBSXQ==
X-Received: by 2002:a05:6e02:66b:b0:338:1c2a:fb62 with SMTP id l11-20020a056e02066b00b003381c2afb62mr5891766ilt.3.1684801372152;
        Mon, 22 May 2023 17:22:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q19-20020a022453000000b00418b1c5cd64sm2070908jae.93.2023.05.22.17.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 17:22:51 -0700 (PDT)
Message-ID: <c7eee355-a430-1d05-d06c-431a97bc9297@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:22:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
