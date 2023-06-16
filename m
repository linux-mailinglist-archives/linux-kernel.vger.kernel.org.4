Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7587E7335EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjFPQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjFPQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:23:15 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4822D72
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:23:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a1fa977667so1036679fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686932592; x=1689524592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=82lTB4+3Vquz8SEapgRewIbFRq4sI1EPFHTcQMWOuo0=;
        b=c90Wj5O9cXsIXh/BpCZemnIGSSrnYRhfXBUW0wq4i1T/6IYYUAcP2sov0Czj4afwJr
         ndCAjc82/Fkm4htVXRewTN8ltSkFl5k3GoKVcgeu/5XvhVj92+WbnWvVlCT9rRznRSzP
         xpa9Cbor4HKC7tuiAe4HdE2c9JQTkvtBLPEBYoDrN/kYIxsCJTBfXRV/KEUjsJqV0Ihj
         E7QeLD1G8alhGoNujTr798PCJqjB8V8DWV6n3bbQWjIlD//jn5/b3z7htx8GFZRdnfih
         Q6wZ/z2aCf9hDhSP57C7Y/nPpWHiz+N7dgktEzmgxCNOKJpWwOt2PUl0ELDqM+sRy9uN
         s3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686932592; x=1689524592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82lTB4+3Vquz8SEapgRewIbFRq4sI1EPFHTcQMWOuo0=;
        b=KGFOqPqaxKvGCKcvRP4p6DtqzOkd57JYxeVp9vF5FLhL87BRlxbivXk+nBc5DK7QdX
         FZOYjJzWq6Z9XraWEyibeuaQkh0QHivfsbngChWssLWck6CVi/uJS8iF4Qo9G10xqUV0
         Sqt6rRoWfaK2Ovm4INSp+A35VaGbDbbOOGftteHGszHmXvaczDcoEpfqYdXS2TrcscOb
         BFptHcrVfj53xTYIUx5Yvu1ENpLlygB0NWUOOY0mbingQNfpWnUQizjAzrGAIbTL+cwk
         7wS7X4CGOdXIYnd7fv/22HmFuBpxsdcq2bRcjfo+x7G23XJz2JMQvAOoPYHIOTGY1fMG
         exgQ==
X-Gm-Message-State: AC+VfDyxlwqKmBF6AUNWl6OdpX2DQr7sSnzzfNcekhkpmI4qpaLvFQNE
        6Kc1wWviJCZPSCyiXtnBqdZZvf2vA0beODKS5BgKyA==
X-Google-Smtp-Source: ACHHUZ4PM5m7JuiU2ThA7DOCue+LNUdpG0GGrtMdxTGIYaSFF6Y82pfrRL3+XfRHK8mpMMuOgebmCfV5Z1f39UR4h6w=
X-Received: by 2002:a05:6870:5b16:b0:1a2:c149:99cc with SMTP id
 ds22-20020a0568705b1600b001a2c14999ccmr2904192oab.24.1686932592435; Fri, 16
 Jun 2023 09:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230616035813.255062-1-jaswinder.singh@linaro.org> <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
In-Reply-To: <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 16 Jun 2023 11:23:01 -0500
Message-ID: <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> > Specify bindings for the platform and boards based on that.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
>
I can remove it, but I see many mentions like "Fix bindings for"  "Add
binding for" etc in the subject line.

>
> Binding without it's user is usually useless. Where is the user?
>
It is required for SystemReady-2.0 certification.

thanks
