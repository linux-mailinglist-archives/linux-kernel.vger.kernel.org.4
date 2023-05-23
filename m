Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50F70DF51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjEWOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbjEWOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:33:46 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D14121
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:33:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3980c92d8d6so1401809b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1684852423; x=1687444423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GS7c6oHmTob6/hE6yrL3ruWPbjjNTps0ZQSki01BgBM=;
        b=OOYnMeNzMvIZ/UmDhCqiWGR+hsoJt35UBBjyInbWS0Faszmow8yFWapBWXv3E9qRI8
         fVbAq7Y6g3Jz83v6krxhpMGgYP1vu4CFgrZEHivastnBOVIAuC1PQIf2w97l3H8ScQgB
         A2Edd1VHeF+R2EMPi15RaabTgaj8c5O+NrAto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684852423; x=1687444423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS7c6oHmTob6/hE6yrL3ruWPbjjNTps0ZQSki01BgBM=;
        b=T+smTWYDonQTw8ktTS3wFQI2MxKDouRznxNTDBMLI+vOZypZMUFEM4FF61Glqz5e5B
         JCr1I+Dq+m1YgBlRP3xrIn80g+WcDd+5S6aR9pGq0uPHkM0h2MU8gBT3wskjaqW2mGJk
         CG9O5PvDu+Yg9CCSaNLFXaQuoIynNYMcjsVj2ulkKoaNtm8f4+qAAFNhNowIT1cqzI2l
         zVd3gO25bqvMpk951W7Zw5IiJqENT3HTK+X0aWjkU5vVhRzf9vmqZrU4JENeliO6ektT
         93ye1MwiLQF663zZpYorD8RDxH6P6PqPfLqMyDhCf05V+MrbACsek2mWv7zwXz8RZqH7
         th+A==
X-Gm-Message-State: AC+VfDwL2+ri6iOLawGxALCAI6jgD+ejf8qafa3El7Xb5IlaU7zLJYBs
        9WyWNpZZ+Dm2FtyQyf42MMgR9w==
X-Google-Smtp-Source: ACHHUZ77NQuNSJ/WUE59ifAGWs+jieauwYGmQqT5t+W0QIlmrLSPFN+DDf3VNNqvVy9mlFIG7pDzQg==
X-Received: by 2002:a05:6808:10d:b0:398:2fa5:2eba with SMTP id b13-20020a056808010d00b003982fa52ebamr1014772oie.56.1684852423319;
        Tue, 23 May 2023 07:33:43 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id x21-20020a4ac595000000b005526bfbf131sm3387767oop.26.2023.05.23.07.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:33:42 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 23 May 2023 09:33:41 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Message-ID: <ZGzOxWoPVEwp5/DD@fedora64.linuxtx.org>
References: <20230522190412.801391872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:05:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
