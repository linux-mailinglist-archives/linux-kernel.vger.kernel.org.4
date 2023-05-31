Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50471774A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjEaG4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjEaG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:56:35 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6686E11F;
        Tue, 30 May 2023 23:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685516185; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MhBYktdmi7qHhnp0JwQ0fN/9i4oLCZy7qi3XemQXQP6MtbRQGZSfebeNFI+FL/3Ivf
    hVsD330LZSXybgXQdxf+Mienw/ZJEGTeIGFdgMYMFpWjG3Vm7FHVoKUHcBZuYED93iGT
    cu5/IE6tYovJLw7oyF7IY8Lc6FC4Y21zuMhN/ri/eBj9QNX/ZYEQc/uKzBXL+CEdytbH
    j+vo4/Zqo4X+Sjzh3/sazXiJ0Q6Z8YHf6tBtRUJUJXNZRpvhyo2b/Fx/ZAGEOH9l31lk
    FRM7vuPNGFvadgvCNJ+uG9uy4RRFGX+fiiVr6j5R2zjBaBZoTEC3OW0/u9Tt6lcnhmNz
    vNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685516185;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ac7g930X4TZT8FOVyemqEC3uDwuc7IbCN+icMmcWknM=;
    b=pEBNaXW9yZ1XdjfLtbMwDWu0Qry7fS+KSp7MmZVXMrvS5Cm2+Qb8DMt9zo0YACyywU
    rzk/dgsA+0eZk6Y3FVNCPgs/AOH3+aCgVuotioRb8PHCRhebbBhE3K6dosl41Ei3ullQ
    PbmlsE7W7zB1XYFPhFsj6LyUgnUZAjbRHXNP8ee67gltWzBoivFSzB00YC+WwWaYKzR9
    6/UlIyT1K8MC3uyWtgg3NRjHW6zOtZEGXhFSDno8clVmvbxJF5GSMTZszGmR22KI3Y+U
    z01/LpVWeA9cdEkMsmaJoVSaBUMdw31QY6Enya0lWaBwLaBwyTYNzOqVjyYBMZl5hMXd
    b6jA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685516185;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ac7g930X4TZT8FOVyemqEC3uDwuc7IbCN+icMmcWknM=;
    b=YsKlmPabUrWfmSvqZzxfmAjCYJ3SETAmMPDDABbmdb+PcnI3ZAVWvA57IqmrkaVOwR
    WZPKJgfrMzu/I+4wyYHhcxZjIc3fFEjBO5wPcDuTdeUjeDLko+JjW9shjVYGTXIYJ9vP
    RZOMU/a6Ip/APA27Yj2xirIbbkayF/VXimga0kysOya29TFio5MipV5T1lWh94uX7jIr
    0fMycNlAlE0s6RXPn7ZOU38y5S+ZtPbnUG/KW9blGhV0oZ45Q8SYtqdjhE+PwnKdp3XP
    hNM3cZbu9xlY13iIKeSNI+9j7azfjVqS9D8pnJtfrwvD0W22tNamX6efEYSgot6jiyR7
    4TtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685516185;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ac7g930X4TZT8FOVyemqEC3uDwuc7IbCN+icMmcWknM=;
    b=hNT3tpBGTJ8OQmtlojX2n7CP9DWP7PbR7yaWjktsSFLZUDv8WTvVQpwosa4q2lUmKc
    kPTDv6uXsduM8bk9i0AA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4V6uPko7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 31 May 2023 08:56:25 +0200 (CEST)
Date:   Wed, 31 May 2023 08:56:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: firmware: Use of_reserved_mem_lookup()
Message-ID: <ZHbvkDkkS_pZltMG@gerhold.net>
References: <20230529-venus-of-rmem-v1-1-dfcdc5047ffb@gerhold.net>
 <38a627a2-040d-23e2-5637-32f199d0fc31@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a627a2-040d-23e2-5637-32f199d0fc31@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:36:52AM +0530, Vikash Garodia wrote:
> On 5/29/2023 11:46 PM, Stephan Gerhold wrote:
> > Reserved memory can be either looked up using the generic function
> > of_address_to_resource() or using the special of_reserved_mem_lookup().
> > The latter has the advantage that it ensures that the referenced memory
> > region was really reserved and is not e.g. status = "disabled".
> > 
> > of_reserved_mem also supports allocating reserved memory dynamically at
> > boot time. This works only when using of_reserved_mem_lookup() since
> > there won't be a fixed address in the device tree.
> IIUC, this would avoid precomputing the hard range for different firmware
> regions and also make it more flexible to adjust the sizes, if anyone wants a
> bigger size later.
> Incase a specific firmware needs a dedicate start address, do we have an option
> to specify the same ?
> 

If you want a specific start address (or in other words: a fixed base
address) then you should continue using static reservation for that
component. You can mix static and dynamic reservations. The static ones
(with fixed addresses) will be reserved first, then the dynamic ones
will be allocated from the free space.

I have this example for one device in my proposal at [1]:

	/* Firmware must be loaded at address 0x8b600000 */
	wcnss_mem: wcnss@8b600000 {
		reg = <0x8b600000 0x600000>;
		no-map;
	};
	/* Firmware can be loaded anywhere with 1 MiB alignment */
	venus_mem: venus {
		size = <0x500000>;
		alignment = <0x100000>;
		no-map;
	};

The wcnss_mem will be always at 0x8b600000, but the venus_mem can be
loaded somewhere around that. If only certain regions need a fixed
address this still provides the flexibility to change sizes more easily.

Does that answer your question? I wasn't sure what exactly you mean with
a "dedicated start address". :)

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
