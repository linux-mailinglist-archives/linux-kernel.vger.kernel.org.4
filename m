Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3463DC9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiK3SE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiK3SE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:04:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7FD748F6;
        Wed, 30 Nov 2022 10:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 264A0B81C8A;
        Wed, 30 Nov 2022 18:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DABC433C1;
        Wed, 30 Nov 2022 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831493;
        bh=gbEP0d3/Dzbwbi8UXaAA6LqakazFzwGDxZhVIwGTAwA=;
        h=From:To:Cc:Subject:Date:From;
        b=gdRcWit9svEV1OMGEO104lxJKfZsPqZUsRQnWrIU5xchUhe2lTQeqHINsRIKgD6eq
         anYmi1nDmX2AD8kxTWdfF/KNz9mGe4KMUlHYg4fEYo7xmhbU0yKhdJTMm9i8azTy2A
         P9KB9PuW45tFhours+KC7ZoVqz1AP2Ou7C/bpMStDXCc2AQ/YBalUn6isD5Ixi09mq
         Uv+rc+R2tp1ZG5HgpJj8tHnd3qtKk8ks4CzAXilJbXVyQm1PHzswrhD26Vs82awLz5
         G3y4C4rx0dAt6NeSFq1x5rQEEI/jq1L0ESfAMYNmTomqmK7JJ4FimzCJdApsMbh/rw
         QEqYPdHcKdPog==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] riscv,isa fixups
Date:   Wed, 30 Nov 2022 18:04:21 +0000
Message-Id: <20221130180422.1642652-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

I noticed ~today~ while looking at the isa manual that I had not
accounted for another couple of edge cases with my regex. As before, I
think attempting to validate the canonical order for multiletter stuff
makes no sense - but we should totally try to avoid false-positives for
combinations that are known to be valid.

All I've changed here for v2 is collecting tags & adding in the missing
commit reference that Heiko pointed out.

@Palmer, either you can take this once the DT folks have ACKed it if you
like, or I will take onto some v6.2-rcN fixes branch. I don't think that
there is any urgency :)

Thanks,
Conor.

CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  dt-bindings: riscv: fix underscore requirement for addtional standard
    extensions
  dt-bindings: riscv: fix single letter canonical order

 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.38.1

