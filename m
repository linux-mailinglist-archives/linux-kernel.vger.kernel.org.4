Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622716B2CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCIS3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCIS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:29:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB573E9CED;
        Thu,  9 Mar 2023 10:29:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so10783757edd.2;
        Thu, 09 Mar 2023 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678386558;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgC3HDaEpmFyb9DAxDUkQOQXcep6v1nc1CwMKps2T+o=;
        b=bGY7djHpyJ7ZwaqMVFVM2S1b/x07wAdwn7rja1U0PCijLYqoed6L+GUz9eZ13SSViF
         li3g4wvKzrbA82E9mHy2p+v4FOPRJVClxMNzOtSz1KlfgM7TeSgRf9UWONZQzsVpphWe
         ILKXQ0CAB0SmchYGh1rGf/2Sl1AnMQ6UjiVIIhF88nDnMuYdahGBFchQJPANuGLV7T4l
         BHQoRnBb0yF1TYV766Dd3dTmwvj5J4A9GUe42nHNoCnA17IuBYHB/Xy4PNvFlDzlmBVP
         mC/yYYpobCHyQaNmQm3QdX5OOrbyawPOF28oj8b5dB9fobR++yA2S5qAMCDL7Gz1jBP6
         lxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386558;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GgC3HDaEpmFyb9DAxDUkQOQXcep6v1nc1CwMKps2T+o=;
        b=lPlrgJHWD9bNKfOiMCOZt991qRlZWeRwkrav7pxeGLn6ZrGHjtdpOcYLDJv4z8f9uR
         FHHiJGHZWoZOyOq9svA83Oc7mFuVC0Sf/SR0ql2crmrzcs86GyeSNjjYymGy760mW79S
         OaOEwWxGRGS57faHe1LpxcagS7uci3M8RLp3NKMj5/JXE3qqlD9/CKsMI1xC2Hlmms2l
         7emLkSA9YW06/XZQ8XxGCJS9hLYr/jqkTkC0nywfP+nRTtn/lF8I5degBF9S9zcJCnOB
         nYbjN+G7aOjbTsdJhio3IUPJcjGeVS+ycqauQqamV0vTpXmR6zbscv351KUHMevDo1VY
         vOWA==
X-Gm-Message-State: AO0yUKUPOm8eFLXmLTSnp0Ol2ocYsHAKyYgVoJdYIFtqmMRCGwdk5Rho
        CSajU+NEdhfACu2bJrAwiBg=
X-Google-Smtp-Source: AK7set8ACfzLsWFpKM3jLkWMhsKGJ2+zm21sGRpeKiJGGPgCQXzThQL5D30LYKf74epYpgKXO4eGlg==
X-Received: by 2002:a17:907:c689:b0:914:4164:658a with SMTP id ue9-20020a170907c68900b009144164658amr11842570ejc.42.1678386558363;
        Thu, 09 Mar 2023 10:29:18 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906719700b008c673cd9ba2sm9071713ejk.126.2023.03.09.10.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 10:29:17 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 09 Mar 2023 19:29:17 +0100
Message-Id: <CR22DNZPIO70.3917L1ALY2HDV@vincent-arch>
To:     "Nick Alcock" <nick.alcock@oracle.com>, <lee@kernel.org>
Cc:     <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/18] mfd: da9055: do not cite as modular
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
 <20230308194307.374789-10-nick.alcock@oracle.com>
In-Reply-To: <20230308194307.374789-10-nick.alcock@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This driver cannot be built as a module, so don't suggest otherwise
> in Kconfig help.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
