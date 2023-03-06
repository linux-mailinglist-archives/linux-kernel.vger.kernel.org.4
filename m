Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5117D6ACDAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCFTQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCFTP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:15:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900065443;
        Mon,  6 Mar 2023 11:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EBF6108D;
        Mon,  6 Mar 2023 19:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD4FC433D2;
        Mon,  6 Mar 2023 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678130156;
        bh=Ye8fF5L4qQexJxXqxoN7GU17SAbd7KXZ1DnaEWwRvpo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FcnciynrfICCRoVPny7ApM1J3wWUh5TfXEn/e1M6KNvjb91D4DaupukW8mdnqwnry
         M6vpZYCTGS/RbO+bYooe6VfvLqU0b6DRwNk63dwfPMQHEgyBilFhbszVEqw2liydLP
         3XAWV1CaW+mHhNrkUNJAzM9iYjzm+sz7jTnWhPlN5xgsvEDjCz2e7u5L1w3+3ypRZ4
         U0GfHT8PJOe3vvKxb7VAWP1UOohBXG2WoSTfEl12AkT8YU0oyarpI+xOMVGRg8q2vS
         wQbBsA1Ij8iX1fwa1vUX4KiBhmIa1j2Mm7rUi/ob4HlQa9qm7ARqqMysZxSwOzNmcM
         xM9jyzpiAbIvg==
Message-ID: <32edd2dd9557b7e3debbd8f1bccccd8d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx-W3o=rQoVLnKkvk=oTAMiwEcqAZ_trcMPBuune-7Hoiw@mail.gmail.com>
References: <20230302014639.297514-1-saravanak@google.com> <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com> <CAGETcx-W3o=rQoVLnKkvk=oTAMiwEcqAZ_trcMPBuune-7Hoiw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Saravana Kannan <saravanak@google.com>
Date:   Mon, 06 Mar 2023 11:15:54 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Saravana Kannan (2023-03-03 13:24:00)
> On Thu, Mar 2, 2023 at 5:14=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> >
> > Works like a charm on U8500!
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Stephen, Does this look good? Can we have Greg pull this in?
>=20

I picked it up for fixes. Will send it off later this week.
