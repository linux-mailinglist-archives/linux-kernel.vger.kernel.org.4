Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BE688722
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjBBSyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBBSyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:54:13 -0500
X-Greylist: delayed 779 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 10:54:11 PST
Received: from out-67.mta1.migadu.com (out-67.mta1.migadu.com [IPv6:2001:41d0:203:375::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2EA10254
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:54:11 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675363233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKkuIcBhnMPwQqCjwGuPemg+WsdnyWvGvpoWQlaePW8=;
        b=SLyiMiDQazrs0FMT+pfThaR2L+4JAEfLk1mOBotS0v+tmE2TwajVRZTjUHA3uFDSxS1byk
        l4aCl1UGjmKsoZ/PqtdZUen4Ti9BENkmhRkKR8GD1IeNpEvhWOlhonN3L0wgVG3TMV60qT
        IeVASyUaHw3Xa3TSpUIN0B0EE1JHleY=
Date:   Thu, 02 Feb 2023 18:40:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <e3b80d80bb6e2ec5db7fac427d0a44b7@linux.dev>
Subject: Re: [PATCH v4 0/3] Add USB/DP combo PHY config for SM6350
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        "Vinod Koul" <vkoul@kernel.org>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Johan Hovold" <johan+linaro@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CQ84AYQ4TTU1.JLLJCL8OFCFQ@otso>
References: <CQ84AYQ4TTU1.JLLJCL8OFCFQ@otso>
 <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
 <Y9u4cAK+uKXuu+uL@matsya>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 2, 2023 8:39 AM, "Luca Weiss" <luca.weiss@fairphone.com> wrote:=
=0A> On Thu Feb 2, 2023 at 2:19 PM CET, Vinod Koul wrote:=0A>> Signed-off=
-by: Luca Weiss <luca.weiss@fairphone.com>=0A>> =0A>> cover doesnt need s=
ob :)=0A> =0A> That comes from b4 ;)=0A> https://b4.docs.kernel.org=0A=0A=
There's a number of subsystems that will use the cover letter as the base=
 message for the merge commit, which is why the signoff is added to the c=
over.=0A=0A-K
