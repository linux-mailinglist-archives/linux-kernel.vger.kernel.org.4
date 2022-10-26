Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5460D9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiJZDYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiJZDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:24:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CFAC39E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:24:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id b2so17932880eja.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCzzirgjwOdUAnOkRY53VJyqkWpOMP9smR0zkz0PYTo=;
        b=Eddol3R5wxuDuqINpE1iuUEar3C1wHj4Ohl35+H7sX5BqnpqoQ1rGRk/SygDLmx+wI
         ee4YKWc55O1xuZhLgpVdawjS9Oz2DCOE+MG/TYL3d1j8/msCw+qHOMF9nRTy+Mk0h7UO
         JYyuw/HM7Zgt3CzJ9y3PZ3+Ap9ivgk5lRGrGSY66BwGqUSrA/xGYwyItp8HUzKN11WRw
         yJzIOdaCrkGigP2RxrtbJ8i4YX/P96hienWdXevqyhPDXe949R7YNZHKdNLIUrUno8Xz
         LPTICeJj5jOZV94DeoiCa+pYacT7eHLWx4X+bsFJ43ne123/1gRYnl45RwJyewZTv2/7
         oN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzzirgjwOdUAnOkRY53VJyqkWpOMP9smR0zkz0PYTo=;
        b=nh3k8wcMR9r5K5led+y87V+3gERuuwC9jgdC3W62f9IszKiq6Dz6mHCLkQSBcaNSdW
         24cDI8IgV4vRYnsow1Ev8sJ/0+1h+V1C42VmLWz5rt4yG4gzpQtFnZh+B7VM/z+XvzKi
         tVgGDqXPVDZrOH6g8S9izoNAMm/9T0vXbWLDVLniRA2Wl4DuNHh9hNRNkCru0S80+bVe
         EDG7S4QkIateAIGvDIDnK/qzxiKSfnDqz/IA3ndq4+UEq3VKDWYZtwzNRHO3UjCIM7o0
         HoSDci2Ei7mmcrFEOayQJYE5RTgDM0K5WWLksPPBGGnlU1Fedy/XBDMMATDOxpPh7Kgg
         045A==
X-Gm-Message-State: ACrzQf2rVBjf09XDzNBWE2YynR9cJ2IamITV3vzOHg0M2Vls/OZwRNEz
        rLb9qzVpOypjFORA/bKLTHY=
X-Google-Smtp-Source: AMsMyM6ZoEN3yiCLyBdNCGFw96yq+oeOazpuBqB89ZxlVjDwzMWdIsldOrC9h1JhWdM9KUq8Uhvl2w==
X-Received: by 2002:a17:906:c151:b0:78d:cdbc:9fb7 with SMTP id dp17-20020a170906c15100b0078dcdbc9fb7mr34069296ejc.688.1666754653365;
        Tue, 25 Oct 2022 20:24:13 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b844:c952:3daa:e0a:40ba? (p200300c78f2ab844c9523daa0e0a40ba.dip0.t-ipconnect.de. [2003:c7:8f2a:b844:c952:3daa:e0a:40ba])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm1409251eje.46.2022.10.25.20.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 20:24:12 -0700 (PDT)
Message-ID: <365358f4-eabe-8d91-e585-733cf1bb9924@gmail.com>
Date:   Wed, 26 Oct 2022 05:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/17] staging: vt6655: changed variable names: wFB_Opt0
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
 <62f69eddc9641ac9eb045edf8a9453bf36a02b36.1666740522.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <62f69eddc9641ac9eb045edf8a9453bf36a02b36.1666740522.git.tanjubrunostar0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 01:36, Tanjuate Brunostar wrote:
> change variable names wFB_Opt0 and wFB_Opt1 to meet the
> linux coding standard, as it says to avoid using camelCase naming style.
> Cought by checkpatch
> 
> Signed-off-by: Tanjuate Brunostar<tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)

Applying: staging: vt6655: changed variable names: wFB_Opt0
error: sha1 information is lacking or useless 
(drivers/staging/vt6655/rxtx.c).
error: could not build fake ancestor
Patch failed at 0001 staging: vt6655: changed variable names: wFB_Opt0

Please rebase
