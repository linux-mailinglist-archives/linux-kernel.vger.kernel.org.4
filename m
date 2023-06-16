Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A4D733B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjFPVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPVFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 17:05:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306753596;
        Fri, 16 Jun 2023 14:05:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A0961B11;
        Fri, 16 Jun 2023 21:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7532C433C0;
        Fri, 16 Jun 2023 21:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686949539;
        bh=6cnCdUSqLz7VhNzN0lbB/Xqj6xFuU/O/NQabQhB7NiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7i0S9spk/rq86bSVG2EN5JaWksv1VMyqy/uqYZvc+hC7ysTe5TqccRM2AMZgC4Gb
         6hwENrxSEFBxJluOcHgbDa0OWR3ILdeMYbHMHyoX2OCc9lCWFTZBrWvgPNdsGzfRNn
         aV191+D8dJm0lWZwEBN67SJzMEFHZKTV13/HmKBR+g7Jd07SZKwN2XFltofW83J+P8
         K0YGwMPdMkV2P6Gm5tunFN6kzHDp2DoJ876R+EtbmB8ty94hQRpldVLzmT2J2HhkXy
         AbGjNxMNOS6br8EFkos9pjzwAQolUgXD503u5DY+0bquBHgRMkcbgnhK3ptEYP8v2c
         ZsDo7r0cgzVLg==
Date:   Fri, 16 Jun 2023 22:05:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Eric Lin <eric.lin@sifive.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, maz@kernel.org, chenhuacai@kernel.org,
        baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Nick Hu <nick.hu@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 1/3] soc: sifive: Add SiFive private L2 cache support
Message-ID: <20230616-errand-glutton-f64783da058c@spud>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-2-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wC0nzxIhkPASdtVL"
Content-Disposition: inline
In-Reply-To: <20230616063210.19063-2-eric.lin@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wC0nzxIhkPASdtVL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Eric,

On Fri, Jun 16, 2023 at 02:32:08PM +0800, Eric Lin wrote:
> This adds SiFive private L2 cache driver which will show
> cache config information when booting and add cpu hotplug
> callback functions.
>=20
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

Missing a Co-developed-by for Nick?


> +static void pl2_config_read(void __iomem *pl2_base, int cpu)
> +{
> +	u32 regval, bank, way, set, cacheline;
> +
> +	regval =3D readl(pl2_base);
> +	bank =3D regval & 0xff;
> +	pr_info("in the CPU: %d\n", cpu);
> +	pr_info("No. of Banks in the cache: %d\n", bank);
> +	way =3D (regval & 0xff00) >> 8;
> +	pr_info("No. of ways per bank: %d\n", way);
> +	set =3D (regval & 0xff0000) >> 16;
> +	pr_info("Total sets: %llu\n", (uint64_t)1 << set);
> +	cacheline =3D (regval & 0xff000000) >> 24;
> +	pr_info("Bytes per cache block: %llu\n", (uint64_t)1 << cacheline);
> +	pr_info("Size: %d\n", way << (set + cacheline));
> +}

Isn't this basically all information that we get anyway in sysfs based
on what gets put into the DT, except printed out once per CPU at
boottime?
If there's reason to keep it, please do as suggested by Ben and cut down
the number of lines emitted. Look at the ccache one for comparison:
	static void ccache_config_read(void)
	{
		u32 cfg;
=09
		cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
		pr_info("%llu banks, %llu ways, sets/bank=3D%llu, bytes/block=3D%llu\n",
			FIELD_GET(SIFIVE_CCACHE_CONFIG_BANK_MASK, cfg),
			FIELD_GET(SIFIVE_CCACHE_CONFIG_WAYS_MASK, cfg),
			BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_SETS_MASK, cfg)),
			BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_BLKS_MASK, cfg)));
=09
		cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
		pr_info("Index of the largest way enabled: %u\n", cfg);
	}
It'd also be good to print the same things as the ccache, no?

> +static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int cpu, ret =3D -EINVAL;
> +	struct device_node *cpu_node, *pl2_node;
> +	struct sifive_pl2_state *pl2_state =3D NULL;
> +	void __iomem *pl2_base;

Please pick a sensible ordering for variables. IDC if it is reverse xmas
tree, or sorting by types, but this just seems quite random..

> +	/* Traverse all cpu nodes to find the one mapping to its pl2 node. */
> +	for_each_cpu(cpu, cpu_possible_mask) {
> +		cpu_node =3D of_cpu_device_node_get(cpu);
> +		pl2_node =3D of_parse_phandle(cpu_node, "next-level-cache", 0);
> +
> +		/* Found it! */
> +		if (dev_of_node(&pdev->dev) =3D=3D pl2_node) {
> +			/* Use cpu to get its percpu data sifive_pl2_state. */
> +			pl2_state =3D per_cpu_ptr(&sifive_pl2_state, cpu);
> +			break;
> +		}
> +	}
> +
> +	if (!pl2_state) {
> +		pr_err("Not found the corresponding cpu_node in dts.\n");

I don't think this error message is going to be helpful in figuring out
where the problem is on a machine with many of the caches. More
information about *which* cache caused it would be good.
Also it is not grammatically correct, it should read something like
"Failed to find CPU node for cache@abc" or something along those lines.

> +		goto early_err;

early_err just returns ret. Why not just return the error directly?

> +	}
> +
> +	/* Set base address of select and counter registers. */
> +	pl2_base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(pl2_base)) {
> +		ret =3D PTR_ERR(pl2_base);
> +		goto early_err;
> +	}
> +
> +	/* Print pL2 configs. */
> +	pl2_config_read(pl2_base, cpu);
> +	pl2_state->pl2_base =3D pl2_base;
> +
> +	return 0;
> +
> +early_err:
> +	return ret;
> +}

> +static struct platform_driver sifive_pl2_cache_driver =3D {
> +	.driver =3D {
> +		   .name =3D "SiFive-pL2-cache",
> +		   .of_match_table =3D sifive_pl2_cache_of_ids,
> +		   },
> +	.probe =3D sifive_pl2_cache_dev_probe,
> +};
> +
> +static int __init sifive_pl2_cache_init(void)
> +{
> +	int ret;
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> +				"soc/sifive/pl2:online",
> +				      sifive_pl2_online_cpu,
> +				      sifive_pl2_offline_cpu);

Got some weird use of whitespace here & above, please remove the spaces.

Cheers,
Conor.

--wC0nzxIhkPASdtVL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIzOnAAKCRB4tDGHoIJi
0qXrAP9I4dkOKQEZhScuLXuEiX6wodn8UZXmdAIfrNoRy5PCeQD/S7nbJJrzxs/e
2tvhVnxiJgt1PdRYTwuj6gILbgvnpwM=
=fRw3
-----END PGP SIGNATURE-----

--wC0nzxIhkPASdtVL--
