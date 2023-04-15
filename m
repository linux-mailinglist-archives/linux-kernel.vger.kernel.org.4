Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58506E2F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 07:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDOFxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 01:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDOFxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 01:53:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A5E59E7;
        Fri, 14 Apr 2023 22:53:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 35F8A5C00BF;
        Sat, 15 Apr 2023 01:52:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 15 Apr 2023 01:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681537978; x=1681624378; bh=ps
        oYRU4KvpB4yLh1hj8oU2nadP/9OUl/cZVjATKPRWQ=; b=Zo6TvkhSCkeBp/Hdiu
        n7NlKpS6K2vCQx7h/0UiHwUWmyhq8c+6VET2mphM/0mA8VUaYTphe37JP91moHi8
        s5s3cFYbRusdfYyj/dXHmu1R+8eIlExFJ4iiCSEPCQuHx+HDC3CAjVs8zBPZEQcR
        7fcAeSXB8rpEeWoxdl08qE4927dKVAdk9Sbs7hslN/quiIfzlwFZ9nadrTSo9aRH
        646HmuPURuSyCuYvkrVN0UFSrPGgl8y0q8lHwQNkOyBpjoH1rWAl+zblam5k3s47
        BwMLj5TpKYNj2yCpaoJt0LX/EedTrI7xr6YxWKuRKtRjoCWpHVP38jl6xA0mhlw4
        iQSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681537978; x=1681624378; bh=psoYRU4KvpB4y
        Lh1hj8oU2nadP/9OUl/cZVjATKPRWQ=; b=L3fERuSk04ObKak0zLvYxuhR5YPXs
        7JBzWTBB+9U1lvPP32L5qJB0olsDwEa5ybMU1teDsyG6GNAEPJXIf0qV4mhe7TvT
        EI2OA8E/NpvShax7j224GILWQBU5AwrFteuXUzdMU6OGYEb1WJRtF6UW93uJ9uT1
        Qp3/JuRQWdzlVYIgs19x1wZlmWk6bgtq97GNHwDY6VRCChnmJuwbasqJKpskVjl+
        turOth/fpZAGxa5G/WP4dEbSM4+3E8TMi4G4DL2zqLmWvYz/WX1/s4vE26j2uNFN
        zaqJPwqCpI5F2KCnR4NihItb9R21vWJM6c1THrgaqXTHp7hZrsGKN2DeA==
X-ME-Sender: <xms:uTs6ZJLDuMPXjCqOu83CBjYMoy2lY1P6JrnpX51lwKkYaxxKsxjKww>
    <xme:uTs6ZFKN7oNaAFa-vJN03FL9xXLehsRh5kLUJ1kzhnThe3dow0rB1QXRPb_8zfjoL
    nsbHSFa3_LpDQ>
X-ME-Received: <xmr:uTs6ZBswgtrBWgmpgaF8DTEOg6_A9Cc0VM0vZJy-BDbdEUuZLJ7c-cZRLpMgFSV2XJ3T7O4aDywEKsrlYw7uvQLzCW5H7jJw7E1RNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeluddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:uTs6ZKYpbghumWykQPMWR-li9-McQoC85-q9Qig46AEZmqx4qFTXDw>
    <xmx:uTs6ZAakniXGPQoCf4LDCukv-3G_gH09BVj24IHwVD75ZQok0zoS0Q>
    <xmx:uTs6ZODWV3bwWV_WNfd8nKmun_HsQyA-5_mRqWU6hVIhMVZVeWoS2Q>
    <xmx:ujs6ZMTUZsXFQKX8xQTKtulJyPlAwHS-d7SBGcwivHIpU2LiW-zrkQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Apr 2023 01:52:57 -0400 (EDT)
Date:   Sat, 15 Apr 2023 07:52:55 +0200
From:   Greg KH <greg@kroah.com>
To:     broonie@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 devicetree tree
Message-ID: <ZDo7tzOvzzET8Rs8@kroah.com>
References: <20230414151326.2134818-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414151326.2134818-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:13:26PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc tree got a conflict in:
> 
>   include/linux/of.h
> 
> between commit:
> 
>   82174a0a9c5cf ("of: Move of_device_get_match_data() declaration")
> 
> from the devicetree tree and commit:
> 
>   673aa1ed1c9b6 ("of: Rename of_modalias_node()")
> 
> from the char-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/linux/of.h
> index bc2eb39dcf753,9b7a99499ef35..0000000000000
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@@ -370,8 -373,8 +370,9 @@@ extern int of_n_addr_cells(struct devic
>   extern int of_n_size_cells(struct device_node *np);
>   extern const struct of_device_id *of_match_node(
>   	const struct of_device_id *matches, const struct device_node *node);
>  +extern const void *of_device_get_match_data(const struct device *dev);
> - extern int of_modalias_node(struct device_node *node, char *modalias, int len);
> + extern int of_alias_from_compatible(const struct device_node *node, char *alias,
> + 				    int len);
>   extern void of_print_phandle_args(const char *msg, const struct of_phandle_args *args);
>   extern int __of_parse_phandle_with_args(const struct device_node *np,
>   	const char *list_name, const char *cells_name, int cell_count,

Looks good to me, thanks!

greg k-h
