Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911BE71727B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEaAdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEaAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4F12B;
        Tue, 30 May 2023 17:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695C663587;
        Wed, 31 May 2023 00:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E112C433EF;
        Wed, 31 May 2023 00:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685493210;
        bh=jDKf2BOhV0iXksWjHDTqHnclajRzaEijKxq3NDH0Gyw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=guEiyPG8h6wqvKgeFVqz8PMfI+7RLp937amHmy6Ku/hxYLs+5BX6RTVBQhIO9wJ+m
         2AzOejGAx8vRyiDObgPhG6U7irxHXr/e6QXy3vzeZujrA+csI8MqIkWfvNANEEci/X
         U2QSiPyV6qJu1nFkUA9BOS458eI/IBl8z0b3NN1XL1C+avh2dquQYVQgUjzE7uFFs3
         QiMfOaNsC/T7hUonK1cQ1rOTkxmGqjkVjSfdOmWidKQiN5iVdc9z7d8ZYYgoxSttXL
         Bj4BGSollvJ1iGvxtVGQa309s/iIRQwDflnvhcRED/321un5EEVaFYS/WyIMgOfWyq
         7iBK6GF3zFkog==
Date:   Tue, 30 May 2023 17:33:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Elder <alex.elder@linaro.org>
Cc:     Bert Karwatzki <spasswolf@web.de>, Alex Elder <elder@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ipa: Use the correct value for
 IPA_STATUS_SIZE
Message-ID: <20230530173329.0fba5ec5@kernel.org>
In-Reply-To: <694f1e23-23bb-e184-6262-bfe3641a4f43@linaro.org>
References: <7ae8af63b1254ab51d45c870e7942f0e3dc15b1e.camel@web.de>
        <ZHWhEiWtEC9VKOS1@corigine.com>
        <2b91165f667d3896a0aded39830905f62f725815.camel@web.de>
        <3c4d235d-8e49-61a2-a445-5d363962d3e7@linaro.org>
        <8d0e0272c80a594e7425ffcdd7714df7117edde5.camel@web.de>
        <f9ccdc27-7b5f-5894-46ab-84c1e1650d9f@linaro.org>
        <dcfb1ccd722af0e9c215c518ec2cd7a8602d2127.camel@web.de>
        <694f1e23-23bb-e184-6262-bfe3641a4f43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 18:43:54 -0500 Alex Elder wrote:
> > IPA_STATUS_SIZE was introduced in commit b8dc7d0eea5a as a replacement
> > for the size of the removed struct ipa_status which had size
> > sizeof(__le32[8]). Use this value as IPA_STATUS_SIZE.  
> 
> If the network maintainers can deal with your patch, I'm
> OK with it.  David et al if you want something else, please
> say so.

It's not correctly formatted. There are headers in the email body.
