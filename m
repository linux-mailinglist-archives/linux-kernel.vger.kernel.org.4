Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7934D664DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjAJV0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAJV0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:26:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15503BEA1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:26:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so32087778ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oFkb9wrIT8eTAaflkSTF4Ydc5BvSrFFAymLLMDqe6g=;
        b=msJKeyEvY7GID76O5kFlxpt8f5s/vI4YPV9ErcdKI54Eeofugxd13XF+9Fj+VU1KDU
         L76Ub5Cg6PamZgJrluJr7GciOV4eefzq8X1X64xArnWv2HcDHFtKoPK+KB+WpkKjUx8j
         3zbIvtSw3dV4MwU9kVRTLJwUTi9b9el4MbxYJ165YTT/zCyhyjGscjPK/gDihU55b72c
         o0K8zDn+ULhGn3I3PISM+70uMIiEdUb5obfUGSXfuKO9Nz5DZsE/TeBs0Dke0cS2AdqG
         a5FRgElSTqVdFKyRBl4y+VXLPv27FkzenpLSx1fXT5JkYpRB0bd5h0sEjRq4eR3nWjjq
         Q2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oFkb9wrIT8eTAaflkSTF4Ydc5BvSrFFAymLLMDqe6g=;
        b=H3Abpy7FkIOLAMmw85anVURBD0JLNpzdEGkNxr4dg/eFKn7HAc1lSR6Gx2DrA2JG/Z
         UxMNkF3OysGsdp2ZbMdUX0sHmskzKbDDftmTAEjyuYcOrwDgsUOKEIlwHTva7LVZIar1
         wwFcQ8tIbB4v0uS+ouhb3PsVTaR22TFQ/5v/yh3TAKTObFMUstLVqOK9qgrDWDAmJ+4I
         z6yIGwAx1QQqw3L5kX6p8o1CYVBTAWPkGwMy5pNEcT0PSDBp81B19F45hAJLDuNp6GUM
         cX+NzwEykND2IlpVxKyDQmVWrxtI1x3UxHPYX5syzP4MXwsuqrge/5s9XdXzm9iaRsPR
         LWrw==
X-Gm-Message-State: AFqh2kplE7/E5vrWZRJSxUAPlvdUPsa/b2Mob+ir5u4VyW9BhZf4hvo3
        qElmKAu3hkAG2gQbhy3FEIU=
X-Google-Smtp-Source: AMrXdXtjdLaVSsoK9Vd/PyTdiPnFSTXjxNjJOXNeZCqR6p0kn6YGs0M14c1nmj/moJVa78VPsEqRVQ==
X-Received: by 2002:a17:906:a1d7:b0:7b5:911c:9b0f with SMTP id bx23-20020a170906a1d700b007b5911c9b0fmr13346595ejb.7.1673386009147;
        Tue, 10 Jan 2023 13:26:49 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906c00f00b0084ca4bd71b8sm5370136ejz.208.2023.01.10.13.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 13:26:48 -0800 (PST)
Message-ID: <59d34f05-f952-2ee9-6fe1-703e5339ef70@gmail.com>
Date:   Tue, 10 Jan 2023 22:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] staging: r8188eu: clean up usb_write_port_complete
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230110205626.183516-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230110205626.183516-1-martin@kaiser.cx>
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

On 1/10/23 21:56, Martin Kaiser wrote:
> Clean up and simplify the usb_write_port_complete callback function. Yet
> again, this is based on the previous patches I submitted.
> 
> Martin Kaiser (4):
>    staging: r8188eu: refactor status handling in usb_write_port_complete
>    staging: r8188eu: reformat usb_write_port_complete
>    staging: r8188eu: remove unused function parameter
>    staging: r8188eu: always process urb status
> 
>   .../staging/r8188eu/include/usb_ops_linux.h   |  2 -
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    | 46 ++++++++-----------
>   2 files changed, 18 insertions(+), 30 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
