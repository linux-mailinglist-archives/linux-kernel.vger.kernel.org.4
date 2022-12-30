Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862DB659AD2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiL3RIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiL3RIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:08:48 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3614011
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:08:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9so5690500pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oM++bh9Bh4axNAul7AUOReOANFnvoVaLIIEIZ8Gw2KE=;
        b=nr7Y49BkQKTNbGyN4IedxtT58gl4JEeQzDG+hQLfK/wDUWARdJEyhwXUPM9Y3V/S0s
         rJFbtb3Q8aDhB37kqsT2QWqPxE5bZYr7ACiuljJUQdmAG23NR9fK5ysW9M0D9eIwiLIq
         lzO9kK9l4J4vhqK7tqIes/Iqw8ZR7Ag3N5hTZ9h+uOLRqBQbO/aXRWNJBuUK41euOIAC
         LgVj2tSLa8gdA7zs1TCbIbKNi7TpebioHiesui46bzodtNKJrKP3NbTS6+B05WsTLVgH
         cppSpjMxSgrf5oTk5ECI+G83JvpKGgfTcAKjnoO9u5dxWlSJH+oXZ7JRAL6S56cVRVBb
         uSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM++bh9Bh4axNAul7AUOReOANFnvoVaLIIEIZ8Gw2KE=;
        b=3bijrwq14vZwN0Y/GuhLLEHrI6aU77h++3ccqxFr7qJnCjxSjknqzn87xnTi8hrp4P
         i17hz2h0PVv7o75VbPpC8LdLZ+tNM8DKVHRDxGqacNlCFiSG3KeCDd4FirGpXcBsqmVJ
         RUac+axYohobM6ZdT5gYxc/J80k97bNmDS9MjH5aDJmotlsyfCZSPQw/+ZQU7lYnFSaL
         45Lx7hkJ5Yn57D6hDsmsHI/Vg2UANwezgmSBGXDdo0HGo+GbXRl+S8q0FmCFOQsOLvdD
         ENp4NGyY6eWUgWkX8AnUGWaSrncq+WN6TKIhIBwY7XASnuSLKUDu9HrJNxhxdDeHUtZB
         f48w==
X-Gm-Message-State: AFqh2kp8kngtUp0SNUpCW5v37vW8B5GgIczqemrSr8mew3vKEwcBfwn7
        YsZid/bCGL48oEf6tKBiMaL8AwJUw4Uw7Afu0UBWBg==
X-Google-Smtp-Source: AMrXdXv9K0gsrBxyagf7trADmKRTTVIlqkB8DMDLyGBOpb9C1KtINwxTFwzptVOOileVXZv8XEVrH4c5p9uWtkL16E8=
X-Received: by 2002:a17:90a:af91:b0:219:536b:41ef with SMTP id
 w17-20020a17090aaf9100b00219536b41efmr2904558pjq.71.1672420127701; Fri, 30
 Dec 2022 09:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20221230094021.575121238@linuxfoundation.org>
In-Reply-To: <20221230094021.575121238@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Fri, 30 Dec 2022 12:08:36 -0500
Message-ID: <CA+pv=HPDLWQNJGTCGjdEfJ+q=M3QZXKtkPSxtRcadqX8A2yFRQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/731] 5.15.86-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 4:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.86 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 01 Jan 2023 09:38:41 +0000.
> Anything received after that time might be too late.

rc2 - Compiled and tested on my x86_64 test systems, no errors or
regressions to report.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
