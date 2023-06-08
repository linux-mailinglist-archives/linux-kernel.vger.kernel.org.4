Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6607286DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjFHSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFHSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31E19B;
        Thu,  8 Jun 2023 11:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449B665038;
        Thu,  8 Jun 2023 18:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D11C433D2;
        Thu,  8 Jun 2023 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686247558;
        bh=V7u42f2naBOqDowPjpRoAY5sWdX646Mwb4Elfsu16zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bN4mvX+pIWEBE0jiHvTzGzCqSYj0xamnFlHcCq26lbRNO0jlsXx4ozmK2CCbIZ3Tq
         t9YD0j21cFPvUWQ4nAln0igiH0Q69gaW3pVo6ISPbv6aKnX3L/IKcS6r0ldqlVSy1P
         P2v0wi5URP+bEKZoXxbezTw7/AZTH7uWADINlLivU306OcNjmJ8Q9LTRVQHeTszTTq
         F/wJ9qf67h0yDWXk3rw300lUinTEOzQ+y/L18eDQNXz4IuK4czNYH6srgum7JeUwvY
         A6SdOGKD7svJzIKfZ5llVHKsaaaRo+vA5TMNjRvgw/quMriQgFvZty1RTuNgu4Ut72
         Lo3XFhDmBwtxQ==
Date:   Thu, 8 Jun 2023 19:05:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, Andrew Jones <ajones@ventanamicro.com>,
        palmer@dabbelt.com, Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rick Chen <rick@andestech.com>, linux-kernel@vger.kernel.org,
        Leo <ycliang@andestech.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230608-unlucky-carpenter-b3a95f269712@spud>
References: <20230608-sitting-bath-31eddc03c5a5@spud>
 <168624654839.3085745.9088493205796442132.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+RuwJ2DDVfOcEYrF"
Content-Disposition: inline
In-Reply-To: <168624654839.3085745.9088493205796442132.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+RuwJ2DDVfOcEYrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 08, 2023 at 11:49:08AM -0600, Rob Herring wrote:
> On Thu, 08 Jun 2023 17:54:05 +0100, Conor Dooley wrote:

> > As a result of implementing Sean's suggestion, I believe I need to add
> > riscv,isa-extensions as an exception to the rules preventing vendor
> > properties being of object type, otherwise dt_binding_check is less than
> > happy with me.

> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
> 	Additional properties are not allowed ('additionalProperties', 'properties' were unexpected)
> 		hint: A vendor boolean property can use "type: boolean"
> 	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an implicit type
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	Additional properties are not allowed ('additionalProperties', 'properties', 'type' were unexpected)
> 		hint: A vendor string property with exact values has an implicit type
> 	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
> 	'boolean' was expected
> 		hint: A vendor boolean property can use "type: boolean"
> 	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
> 	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

Yeah, expected. I think I need an exception in vendor-props for this to
pass the checks.

--+RuwJ2DDVfOcEYrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIIYgAAKCRB4tDGHoIJi
0l8IAQCHNhFWGWR69Rcpmeno9mCNvE7EiV05GSVbbHObbpVtJQEAmK/PJZ+JTtyj
f1qtwj+vdUYA/q/Am73pR9cOA/e51w4=
=3iEw
-----END PGP SIGNATURE-----

--+RuwJ2DDVfOcEYrF--
