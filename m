Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8713673FA23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjF0KYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjF0KXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2EA30C4;
        Tue, 27 Jun 2023 03:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11962610AB;
        Tue, 27 Jun 2023 10:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEA1C433C0;
        Tue, 27 Jun 2023 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687861346;
        bh=rlpX/P3zrocLpUrEAZLC4IOtXF3bWig/tbpzZlx728U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzo6CX/JICF6laRbb5rg5ZZ9C/HgS1MyqeUmBuAytrJqABgzHz48Odr0YBYbRsK9E
         penqJW9HwO542uYgRV8jsDoAv/VzTgyjjOTA//CgN5kwo3DWXPfApogaTVXRdG4gG/
         zY0FuVh+6j9mOeeBZ1a/AQhq9IZdZfa3AWR29/sg=
Date:   Tue, 27 Jun 2023 12:22:23 +0200
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
Message-ID: <2023062734-smuggling-bulldog-a46c@gregkh>
References: <cover.1687855361.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687855361.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:19:23PM +0530, Souradeep Chowdhury wrote:
> Changes in v24
> 
> *Implemented the comments in v23

That explains absolutely nothing about what changed at all.

What would you do if you got a patch series that had this as a change
list?  What do you expect us to do?

{sigh}

