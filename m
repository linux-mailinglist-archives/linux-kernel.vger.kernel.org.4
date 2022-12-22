Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB16547C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLVVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLVVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:20:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C410FEC;
        Thu, 22 Dec 2022 13:20:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i15so4685212edf.2;
        Thu, 22 Dec 2022 13:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U9J0SAOJWmGg3K+OYwmd0BD0E3Ym8yEDir998iVg4B8=;
        b=hNgAdv6CJv+fGQM1pzmmqDVEAdsmQ3tjZltuJAd87S6ssz6ZUmn2LevZ7lQlhIuefz
         MNNugjW0FXa7H9YS/nUz1fWi9J7C4QQpUxBfPukCajzr4OpNMmS+rxIrZVjr+o7XsRo9
         5Z+iwkgEiHuTEASxV0sOAcP2iQAuHv45bFdsn/Nbmeh+tXfUmkZZRNkkESREC2mbB1WD
         XF/F5EXhQcb3B7G6wo30Uf7w15c4RYkUihg3UxPASgdBaDIfbiACQ3NOdgNAdL0Qcn/E
         yifDo9hiAHiofQLEHTff8tGQcJtrn/GNr8lNrsmwmUE8/7riIVUVYwPffQcyyB4cCgE6
         NCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9J0SAOJWmGg3K+OYwmd0BD0E3Ym8yEDir998iVg4B8=;
        b=3mduN0N1fgkv51I/7spcceXohn2K6ACax3TxrO3lbRPQ4Kv8qQdZ8xhE48TmoVXWUV
         ov7KlozIQjHHojpQymPqJ+pR/1eHk7BP8f8xaXypuWUiOnHhmpGsbImM0fpm6mjbG5MO
         dC8yfiQmr3ll4HOFhF7CTmYpyf8Z0ddF4urand5iNJ/huHVYFlx0ki45B9paQFAUU/vy
         +pIaloTr1WNCkSIWQHFcSytJF7kMmzldlampgYlV6uNuoWpuZGasx2H6qi+Q7oC9f8np
         gjf/Ai4gRdmMbqQfFPCTvSAaBQFPHiXz1HeOzLqQCosoMVAMVCdAnsLg675jviO3R1YB
         Y8Dg==
X-Gm-Message-State: AFqh2kpOvk2cH6ZQrfwbmFV1B8dQkePReGFftobSOMzrjO1e9EHKdZC6
        sDcEfvR1k3zooS0XEyE8BGC1/F4a1J5j1E8xUtUvOr2XGik=
X-Google-Smtp-Source: AMrXdXueYdmjnNh5yZELCbKtKxe28suM1LRbcNb1OFiOLZtELR4RzoTx0nAysskex8TahO1zsxYVCAYPELpmaGm7FRk=
X-Received: by 2002:a50:ef0e:0:b0:46c:fa25:f03d with SMTP id
 m14-20020a50ef0e000000b0046cfa25f03dmr871442eds.291.1671744024348; Thu, 22
 Dec 2022 13:20:24 -0800 (PST)
MIME-Version: 1.0
References: <202212222251.Xacx8c4D-lkp@intel.com>
In-Reply-To: <202212222251.Xacx8c4D-lkp@intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 22 Dec 2022 22:20:13 +0100
Message-ID: <CAFBinCAB0VuoKKm4YHv_zB1d1xN3nP0=-xg9EotiWMJ_vikc2w@mail.gmail.com>
Subject: Re: drivers/hwmon/jc42.c:477 jc42_readable_reg() warn: always true
 condition '(reg >= 0) => (0-u32max >= 0)'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter et al.,

On Thu, Dec 22, 2022 at 3:36 PM kernel test robot <lkp@intel.com> wrote:
[...]
>    475  static bool jc42_readable_reg(struct device *dev, unsigned int reg)
>    476  {
>  > 477          return (reg >= JC42_REG_CAP && reg <= JC42_REG_DEVICEID) ||
>    478                  reg == JC42_REG_SMBUS;
The bot is right: we can omit "reg >= JC42_REG_CAP" as it's already
covered by the fact that:
- the reg variable is unsigned, which means the lower limit is zero
- reg <= JC42_REG_DEVICEID covers the upper limit

Before I send a patch I'd like to hear if removal of "reg >=
JC42_REG_CAP" makes sense to other people.


Best regards,
Martin
