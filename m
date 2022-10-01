Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0A5F19BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 06:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJAEBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 00:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJAEBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 00:01:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3310F1;
        Fri, 30 Sep 2022 21:01:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so5675645pgb.4;
        Fri, 30 Sep 2022 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=xBo/CftijzOZqkXLxJxm2wPfWqBicyrtdJ0UG3wUhMU=;
        b=UI/pqthtUPhXo5VIroerhfH2ZyqsiF5l31+DScpWPz7xKAZdwX9plXgMyZ4nhgX/5N
         xgXuvkv8KT0sIDQT7p41dHjlwNH3CIUo6jP1gQJhpCBWE/0+BOSFmYeP92F2dkYi0Deg
         EEyku0AHPbQ9XogWNRypAGYVgytaFPkZ6CU19UiBmowi6Rr811XcKEcRhj+JgGAdRUL0
         dbPtIfJPDrMz5xZrslFopaeFpOa1+DF8ymlgnnOhiIzbqOzyKVBm+KiABqjLtZqTAZlu
         wQo+/D/0l0T8bFDq+8GmzvYZ2kgE/cyODvwcakP9XKdL/Vb3hXUC6KMvoki6xddOcvRF
         FlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xBo/CftijzOZqkXLxJxm2wPfWqBicyrtdJ0UG3wUhMU=;
        b=Q83GVog9wgNNE/b61OmOYByi4C+80PbzZDYkp+Xg4byJRwJCEX9WO/eSMmIm1zEC5V
         NNbojSLYHEJiyH5T4QfjzmOOJKJW7wmjAZWTzN5Srl6R9iYuMRwIsdnYszK2DJugn6Fg
         nZJNIwUii42WmYmsa52Pou1q5gW8tf3lUWChQ4ujFDWd3AR88CzdDYHCU9MetMCgqr4f
         kLahm5hCKR/jvdrBN7VhV5JOzKbOgTXg5+bShkvB7vwqGbXCeEiqCPAXxsO6kUOnVEge
         +XAQqf9GQBkFPU1D7weQBEwAEdQqk8hEFqSPCkrBURxKbntQIEbB4rNT+iAOs4u9LOyU
         fcnQ==
X-Gm-Message-State: ACrzQf2Ny+OCni6UifXZzGxhHEZZnpGXFfwZDeLlHriXbovEeLob6qPG
        lDm0a86p23eNNo5JuWPsbgM=
X-Google-Smtp-Source: AMsMyM53DEEQr6ur4zVq8qM9/HPNM7f4ZCkU2XM9jvarIqKUQ86RVfdYQIfMn6uoGfqL1wGSjcYr7g==
X-Received: by 2002:a63:93:0:b0:439:c1de:3bb3 with SMTP id 141-20020a630093000000b00439c1de3bb3mr10485777pga.319.1664596897029;
        Fri, 30 Sep 2022 21:01:37 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78f26000000b00540b3be3bf6sm2618483pfr.196.2022.09.30.21.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 21:01:36 -0700 (PDT)
Date:   Fri, 30 Sep 2022 21:01:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: input: Convert hid-over-i2c to DT schema
Message-ID: <Yze7nYsh98yGpfxI@google.com>
References: <20220927150916.1091217-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927150916.1091217-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:09:15AM -0500, Rob Herring wrote:
> Convert the hid-over-i2c binding to DT schema format. The supplies should
> probably be specific to a specific device, but it seems they are already
> in use otherwise. 'wakeup-source' is added as it was not explicitly
> documented.
> 
> There's a few warnings for undocumented properties 'vcc-supply' and
> 'reset-gpios'. Those remain as they probably should have a specific
> compatible as well.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry
