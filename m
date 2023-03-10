Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658D46B37BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCJHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCJHsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:48:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84071A5E2;
        Thu,  9 Mar 2023 23:48:48 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j11so16961090edq.4;
        Thu, 09 Mar 2023 23:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678434527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ox2MQ8jOJOp1yMXou1ij0KPIBKyC6rqyU0zHXZznrTE=;
        b=QX+CwDqFVSS7XcQCrN3AHD+LJKuWxxbi5oBnHK04kQ7da5JkKEpStxVVsnDUMy1WRh
         vzysM2wk+rT31PsyRzu7eLCvsyoZwv/6mKu5b3Ghn3lxZ3b949ZRqoVpbWuUN+2sj6Ho
         aHu4zSkIpagwPkapUqK8Zk/yHMd7qsTkA1+GHQFrOnpUJhhXzTE6CXsAR4Un18yj0bvC
         HOpbwxjzYjEWGg4tAAJFTXN9BtOf2vtzy2kP18d9DlfftNEQEfd2GiX3Rnk7jxR/PbY9
         M6TKxONOo+Ah+wpo41iC3dni9Urah+PajVLRvqBI7RMMhnvvLdWFCpj8qkQ485OpdfqV
         m61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox2MQ8jOJOp1yMXou1ij0KPIBKyC6rqyU0zHXZznrTE=;
        b=WZkOiGGSBuOuaM7yb4NwjU4/BozdE+Libq0nXVvBcu/dqyspNe068gLbzJs5oF9NpO
         G0Gr/nfmB9X1+LSLb71oQd3UZUprXBohM3Ehpiz+3pLU18WOQ+JZZBm0KYVfhx5oslfS
         eFNNudfFS45MaElFd5FYXBhcDPoo+hUnyzdiIf4X2JWWGSvheabNiUlrIYC+7oUwYirc
         FW08BPZLxvbscLhzqVxxxzsBoxjApj4Yx7HTiOcoy940gRCnMQyqgRtM44IntYSJGi+N
         5u7Cy7IDbbvoX9AAx8We5FrS4QC0mfziDt6T0zPVMIl00oThf6Rq1GQhlSnZr3Tp1lQJ
         3ktA==
X-Gm-Message-State: AO0yUKUz4BGSsY5cz1CA/YmkmNdq73IbLtkZkLQ8liXkg1tTfJVso2rp
        CtFV4jidYkBzehvxgKuPmQ9DxoBSS0Y=
X-Google-Smtp-Source: AK7set/jErczfvC9adZl0dXU0ALLlrBrgwnYx/lD/8jV5KJ2HnEXYd4CxAnKmoAsWivpJ5VFoWw0nA==
X-Received: by 2002:a05:6402:1291:b0:4ad:66b:84a5 with SMTP id w17-20020a056402129100b004ad066b84a5mr22553135edv.22.1678434526951;
        Thu, 09 Mar 2023 23:48:46 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-172.cust.vodafonedsl.it. [188.217.49.172])
        by smtp.gmail.com with ESMTPSA id c12-20020a50f60c000000b004acbdf23cd2sm496139edn.29.2023.03.09.23.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 23:48:46 -0800 (PST)
Date:   Fri, 10 Mar 2023 08:48:44 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <ZArg3L/ZUCY79Pgb@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
 <ZAb7JVghuiwZF1Q5@wendy>
 <2f03dfb2-5cf8-e954-913c-f0c27db6bcf5@starfivetech.com>
 <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <4c071642-e3c8-4716-a580-5b42e25efb1c@spud>
 <ZAoOLIERMYI8UVlA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <09630acb-f1ae-4dbd-9c9c-9adb1743bfe4@spud>
 <ZAosTc6VNco1okyR@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <23111c4b-2bee-4f04-b0e6-bddea553d260@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23111c4b-2bee-4f04-b0e6-bddea553d260@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Conor,

On Thu, Mar 09, 2023 at 07:03:47PM +0000, Conor Dooley wrote:
> On Thu, Mar 09, 2023 at 07:58:21PM +0100, Tommaso Merciai wrote:
> 
> > I'm able to boot the board using nfs ;)
> > (without issue)
> 
> Sweet, glad you got it working. If you'd like to provide a Tested-by:
> for the series that'd be wonderful too :) No pressure haha
> 

Yes ofc I provide my Tested-by ;)
I collect some other series like gmac integration.
I need to clarify.
btw below my tag on this series :)

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

Thanks & Regards,
Tommaso
