Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D323740A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjF1IIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjF1IBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA31BE8;
        Wed, 28 Jun 2023 00:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAEEE6130B;
        Wed, 28 Jun 2023 06:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B217C433C8;
        Wed, 28 Jun 2023 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687934509;
        bh=H+UwcZ/vjGf77sZdNXoCybxM/WI1ACzxmM96uHWBNHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XteJZEHLN6bRybvpQ5dH0Lfv5gR3Lg9uD1uSf+ZsMr+VveSu91RqojbmvY39VLH8c
         +fUhLebc7dEhDvEamyp7dmW7p9UmCBnfqe2gFB3dxgLkws/9L/puLPHWbk0KvT4HmC
         9fKrmii1w/0lTsjHFVTZxiMQQvug6p1cZn3Lk5pc=
Date:   Wed, 28 Jun 2023 08:41:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V24 0/3] misc: Add driver support for Data Capture and
 Compare unit(DCC)
Message-ID: <2023062831-flail-deprecate-5eed@gregkh>
References: <cover.1687855361.git.quic_schowdhu@quicinc.com>
 <2023062734-smuggling-bulldog-a46c@gregkh>
 <7b0b3f88-9ecd-090d-de65-3d4779b64a91@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0b3f88-9ecd-090d-de65-3d4779b64a91@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:15:46AM +0530, Souradeep Chowdhury wrote:
> 
> 
> On 6/27/2023 3:52 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jun 27, 2023 at 03:19:23PM +0530, Souradeep Chowdhury wrote:
> > > Changes in v24
> > > 
> > > *Implemented the comments in v23
> > 
> > That explains absolutely nothing about what changed at all.
> > 
> > What would you do if you got a patch series that had this as a change
> > list?  What do you expect us to do?
> > 
> > {sigh}
> 
> My apologies on missing out on the specifics.
> 
> The main changes in this version are as follows:-
> 
> * Updated the documentation of the structure dcc_config_entry
> * Renamed "nr_link_list" to "max_link_list"
> * Used u64 where applicable
> * Removed the locks from ready_read method and also dropped
>   the use of unlikely keyword.

Please fix this up and send a new version.

thanks,

greg k-h
