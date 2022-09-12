Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABC5B5E16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiILQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:22:02 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B192A70D;
        Mon, 12 Sep 2022 09:22:01 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1278a61bd57so24712400fac.7;
        Mon, 12 Sep 2022 09:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=r00DFKnjQ6MqdljnOGbZpoS3i+7YfIuY/QvCEDJNxz4=;
        b=GhWPfTyhJqQZoB2Xb40gICKlvU0d01gBDgCNQMgWcIhKIOP8QlDhSdoPBZnGSzJADP
         yFAOX1tkCQj/FMO40wbZBcJ1Fa17sdo3ouzEE2cxV7vY8sJMHkWiCS0VpgYKJIB+PHlE
         b6HQw2/kIf+2I3BvrrEIL04Balu+yEHrCXW96FUumc+Hd33dnaiQvJheWwUvs7eSFTmI
         eWHxdDKNuG7N/mmk9VxnTCeyaeHZvuhaHRZWx50s6fTkTM6thFbGqr+Vs9jbZHVZQnPE
         R+1KebOhKUUynu9wI5cwX6dhINrzK7kAZqg3gVVmA8KqPygh+Zz+HQSbhae2CxqhTH5W
         axNQ==
X-Gm-Message-State: ACgBeo3qvW2r8kkWPxz52SEoCevNu8pF6y7K8U7ujgHam/oIlDrCmEdk
        qbWv/oJ9N6zt9xRL/dmZgQ==
X-Google-Smtp-Source: AA6agR6loyFpBasqevtTvWoqIcVpwvLcLwVcfU8zNnKPyNcqpBvzXAW2C9KsWZEg5Kqo5x6rdL4rWA==
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id x14-20020a056870a78e00b0012b542be5b2mr5139723oao.112.1662999720989;
        Mon, 12 Sep 2022 09:22:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a056870169000b0011e73536301sm5706841oae.52.2022.09.12.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 09:22:00 -0700 (PDT)
Received: (nullmailer pid 1413504 invoked by uid 1000);
        Mon, 12 Sep 2022 16:21:59 -0000
Date:   Mon, 12 Sep 2022 11:21:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, kever.yang@rock-chips.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        heiko@sntech.de
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Message-ID: <20220912162159.GA1397560-robh@kernel.org>
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
> Reduced CC.
> 
> Hi Rob,
> 

Seemed like a simple enough warning to fix...

> The rk3328 and rv1108 PWM interrupt is chaired between blocks I think.
> For rv1108 the same interrupt is used for all PWM nodes.
> For rk3328 only added to one PWM node.
> Currently not in use in a Linux drivers??

How is that relevant to the binding? It's used in dts files.

> 
> No consensus yet...on removing or parent node, so it stays as it is...
> Maybe if you have ideas things will change. ;)

Only that existing issues should be addressed before adding new 
platforms especially if the binding might change in an incompatible way 
(splitting nodes).

Rob
