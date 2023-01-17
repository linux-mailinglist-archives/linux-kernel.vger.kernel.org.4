Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590FA66D40B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjAQCFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjAQCFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:05:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332932412B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:05:41 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x6-20020a056830244600b0068649b4ffd9so91430otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gt3lu2Eo9scEd1w/hLxcrFCpQl1y6EBw4SedxjGpoHg=;
        b=hIf/bK6KpisdKpn0lutY+ug0qSbaAr90xwrHnj4VQRtv4Pr7phmV4mZxbmi/2DPfkq
         sRr2eLSJUfgSAp1DCLEPmyRCqaPql2N3rhvL+Gxdtsr3P2s5/PWf1jBqMAH9H19dEVqM
         LX89U7iXfVS9QTfaj/MPzamrdXBz/0hGEnCWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt3lu2Eo9scEd1w/hLxcrFCpQl1y6EBw4SedxjGpoHg=;
        b=sAfLBIbZ9WPy0pewgUIIXNvMk5S4d0cJj2korsW35voaN1dJUHTFqP6BpJg9yCikHF
         fm1GpjNySSXKIFkcVLMUrblq/4eEdSZyXc5PSmaIHsvLA9lUSFMLIgITLLaKjfjLmzX7
         D26ORw9T9klzS2kTviSZSgNCzoU6niwMhdl9UUpE7kSetoj8LjydAUgDjYX7CsFabs3+
         Jadsoqpq6612RKDbZM+4/45/jqPdQlqn1dCZccobeo8qjUmOtbynoueD5CqS3X4D2JJ8
         /uOWuwjUMTE1qJsHcpjI5CPhzN/pK6lb510tfflsHf1NjKkIDpNHvioPSd/uRYpytOok
         Wvgg==
X-Gm-Message-State: AFqh2kq2e3Z030evxO7c6NP3bdBRSJFnmPjFPb0/BlSvzARzRtBPEXwH
        mE4hui41UNzPzKhLnon+PILq0Q==
X-Google-Smtp-Source: AMrXdXu80sZ8VGqMOHuCEol8vjyQr1hDeoh+HypB+EmkOjHM1dNyPMRxPszGClP+QDnZNueqcHWrYA==
X-Received: by 2002:a9d:72da:0:b0:670:a09e:c7d2 with SMTP id d26-20020a9d72da000000b00670a09ec7d2mr12981255otk.30.1673921140445;
        Mon, 16 Jan 2023 18:05:40 -0800 (PST)
Received: from fedora64.linuxtx.org (99-47-93-78.lightspeed.rcsntx.sbcglobal.net. [99.47.93.78])
        by smtp.gmail.com with ESMTPSA id v4-20020a0568301bc400b00661b46cc26bsm15400639ota.9.2023.01.16.18.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:05:40 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 16 Jan 2023 20:05:38 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/183] 6.1.7-rc1 review
Message-ID: <Y8YCcn1aLoFqI7SL@fedora64.linuxtx.org>
References: <20230116154803.321528435@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116154803.321528435@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:48:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.7 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Jan 2023 15:47:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, armv7, ppc64le,
s390x, x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
