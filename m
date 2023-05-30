Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC0716706
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjE3P3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjE3P2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:28:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DF5EC;
        Tue, 30 May 2023 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=p+s9gSQrQiYw5ODKxvFDAD7YpyqH4RVKdMgrxjPQcFM=; b=i4ihhIyrcbAa91KXE9+2uW2hKD
        JO4nKIWMpyY82Lfp49eIfIph/l0xq/RznS2rGmZMO6fCvP+gu80hbKUiZKP1grTnDRaSnkSTl+hu8
        qqom96t66rZT+nEMtma4BbMJC+7sM5aMZNJjW+HxVboIKQOQaIB5+1eWukJ4VA0CzneM+qZhbudoW
        v4s2fo+AN5zz/Y8n7nxpnD9nOXNaBZ2IKCmOGOkgUYjNxvgSPsHct4RmYCgDVem1OG7vuBlfqiz/T
        EzjuDfJJ5FQEqxcuAgVI3Oc5kv8yTZIWeq/4Hy0ize8Zs+bZBpGRpYZ/AGea5fIGXqpMaYpLRJZrq
        GITtxs/Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q41HE-00EPT0-0S;
        Tue, 30 May 2023 15:28:48 +0000
Message-ID: <44a247a3-e349-94da-8235-1b6911463d78@infradead.org>
Date:   Tue, 30 May 2023 08:28:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] Documentation/process: add soc maintainer handbook
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>, soc@kernel.org
Cc:     conor@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        olof@lixom.net, palmer@dabbelt.com, robh+dt@kernel.org,
        arnd@arndb.de
References: <20230530-multiple-whooping-ee5706fceb67@wendy>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230530-multiple-whooping-ee5706fceb67@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 05:49, Conor Dooley wrote:
> Arnd suggested that adding a maintainer handbook for the SoC "subsystem"
> would be helpful in trying to bring on board maintainers for the various
> new platforms cropping up in RISC-V land.
> 
> Add a document briefly describing the role of the SoC subsystem and some
> basic advice for (new) platform maintainers.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - add Krzysztof's suggested method for avoiding inter-branch
>   dependencies
> - explicitly mention that tags should be signed
> - link to the devicetree abi document, rather than trying to explain it
>   here & reword that whole section
> - fix some typos, capitalisation & unify bullet style
> 
> The devicetree abi doc feels quite out of date at this point, and could
> probably do with a spring clean - but it also feels like hallowed ground
> on which one should tread lightly, so I won't go near that til Rob is
> back.
> ---
>  Documentation/devicetree/bindings/ABI.rst     |   2 +
>  .../devicetree/bindings/writing-schema.rst    |   2 +
>  .../process/maintainer-handbooks.rst          |   3 +-
>  Documentation/process/maintainer-soc.rst      | 178 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  5 files changed, 185 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/process/maintainer-soc.rst
> 
> diff --git a/Documentation/devicetree/bindings/ABI.rst b/Documentation/devicetree/bindings/ABI.rst
> index a885713cf184..93ec82f78ae5 100644
> --- a/Documentation/devicetree/bindings/ABI.rst
> +++ b/Documentation/devicetree/bindings/ABI.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +.. _devicetree-abi:
> +
>  ===================
>  Devicetree (DT) ABI
>  ===================
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 4a381d20f2b4..640d857dabf3 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -136,6 +136,8 @@ installed. Ensure they are in your PATH (~/.local/bin by default).
>  
>  Recommended is also to install yamllint (used by dtschema when present).

I don't see anything in Documentation/ about where to find yamllint...
please.

>  
> +.. _running-checks:
> +
>  Running checks
>  ~~~~~~~~~~~~~~
>  

> diff --git a/Documentation/process/maintainer-soc.rst b/Documentation/process/maintainer-soc.rst
> new file mode 100644
> index 000000000000..9683c7d199b2
> --- /dev/null
> +++ b/Documentation/process/maintainer-soc.rst
> @@ -0,0 +1,178 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _maintainer-soc:
> +
> +=============
> +SoC Subsystem
> +=============
> +
> +Overview
> +--------
> +
> +The SoC subsystem is a place of aggregation for SoC-specific code.
> +The main components of the subsystem are:
> +
> +* devicetrees for 32- & 64-bit ARM and RISC-V
> +* 32-bit ARM board files (arch/arm/mach*)
> +* 32- & 64-bit ARM defconfigs
> +* SoC specific drivers across architectures, in particular for 32- & 64-bit

     SoC-specific

> +  ARM, RISC-V and Loongarch
> +
> +These "SoC specific drivers" do not include clock, GPIO etc drivers that have

          SoC-specific                                GPIO, etc. drivers that have

> +other top-level maintainers. The drivers/soc/ directory is generally meant
> +for kernel-internal drivers that are used by other drivers to provide SoC

                                                                         SoC-

> +specific functionality like identifying a SoC revision or interfacing with

                     I would write:        an SoC

> +power domains.
> +
> +The SoC subsystem also serves as an intermediate location for changes to
> +drivers/bus, drivers/firmware, drivers/reset and drivers/memory.  The addition
> +of new platforms, or the removal of existing ones, often go through the SoC
> +tree as a dedicated branch covering multiple subsystems.
> +
> +The main SoC tree is housed on git.kernel.org:
> +  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/
> +
> +Clearly this is quite a wide range of topics, which no one person, or even
> +small group of people are capable of maintaining.  Instead, the SoC subsystem
> +is comprised of many submaintainers, each taking care of individual platforms
> +and driver sub-directories.

submaintainers and sub-directories ? hm.

> +In this regard, "platform" usually refers to a series of SoCs from a given
> +vendor, for example, Nvidia's series of Tegra SoCs.  Many submaintainers operate
> +on a vendor level, responsible for multiple product lines.  For several reasons,
> +including acquisitions/different business units in a company, things vary
> +significantly here.  The various submaintainers are documented in the
> +MAINTAINERS file.
> +
> +Most of these submaintainers have their own trees where they stage patches,
> +sending pull requests to the main SoC tree.  These trees are usually, but not
> +always, listed in MAINTAINERS.  The main SoC maintainers can be reached via the
> +alias soc@kernel.org if there is no platform-specific maintainer, or if they
> +are unresponsive.
> +
> +What the SoC tree is not, however, is a location for architecture specific code

                                                        architecture-specific

> +changes.  Each architecture has it's own maintainers that are responsible for

                                   its

> +architectural details, cpu errata and the like.

                          CPU

> +
> +Information for (new) Submaintainers
> +------------------------------------
> +
> +As new platforms spring up, they often bring with them new submaintainers,
> +many of whom work for the silicon vendor, and may not be familiar with the
> +process.
> +
> +Devicetree ABI Stability
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Perhaps one of the most important things to highlight is that dt-bindings
> +document the ABI between the devicetree and the kernel. Please see
> +:ref:`devicetree-abi` more information on the ABI.
> +
> +If changes are being made to a devicetree that are incompatible with old
> +kernels, the devicetree patch should not be applied until the driver is, or an
> +appropriate time later.  Most importantly, any incompatible changes should be
> +clearly pointed out in the patch description and pull request, along with the
> +expected impact on existing users, such as bootloaders or other operating
> +systems.
> +
> +Driver Branch Dependencies
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A common problem is synchronizing changes between device drivers and devicetree
> +files, even if a change is compatible in both directions, this may require

   files. Even if

> +coordinating how the changes get merged through different maintainer trees.
> +
> +Usually the branch that includes a driver change will also include the
> +corresponding change to the devicetree binding description, to ensure they are
> +in fact compatible.  This means that the devicetree branch can end up causing

s/in fact/remain/
(suggestion)

> +warnings in the "make dtbs_check" step.  If a devicetree change depends on
> +missing additions to a header file in include/dt-bindings/, it will fail the
> +"make dtbs" step and not get merged.
> +
> +There are multiple ways to deal with this:
> +
> +* Avoid defining custom macros in include/dt-bindings/ for hardware constants
> +  that can be derived from a datasheet -- binding macros in header file should

                                                            in a header file | in header files

> +  only be used as a last resort if there is no natural way to define a binding
> +
> +* Use literal values in the devicetree file in place of macros even when a
> +  header is required, and change them to the named representation in a
> +  following release
> +
> +* Defer the devicetree changes to a release after the binding and driver have
> +  already been merged
> +
> +* Change the bindings in a shared immutable branch that is used as the base for
> +  both the driver change and the devicetree changes
> +
> +* Add duplicate defines in the devicetree file guarded by an #ifndef section,
> +  removing them in a later release
> +
> +Devicetree Naming Convention
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The general naming scheme for devicetree files are as follows.  The aspects of a

                      scheme ...                  is

> +platform that are set at the SoC level, like cpu cores, are contained in a file

                                                CPU

> +named $soc.dtsi, for example, jh7100.dtsi.  Integration details, that will vary
> +from board to board, are described in $soc-$board.dtsi.  An example of this is
> +jh7100-beaglev-starlight.dts.  Often many boards are variations on a theme, and

                            ^^^ Why not dtsi, like the sentence before says?
or is the $soc-$board.dtsi wrong?

> +frequently there are intermediate files, such as jh7100-common.dtsi, which sit
> +between the $soc.dtsi and $soc-$board.dts files, containing the descriptions of
> +common hardware.
> +
> +Some platforms also have System on Modules, containing an SoC, which are then
> +integrated into several different boards. For these platforms, $soc-$som.dtsi
> +and $soc-$som-$board.dts are typical.
> +
> +Directories are usually named after the vendor of the SoC at the time of it's

                                                                            its

> +inclusion, leading to some historical directory names in the tree.
> +
> +Validating Devicetree Files
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``make dtbs_check`` can be used to validate that devicetree files are compliant
> +with the dt-bindings that describe the ABI.  Please see :ref:`running-checks`
> +for more information on the validation of devicetrees.
> +
> +For new platforms, or additions to existing ones, ``make dtbs_check`` should not
> +add any new warnings.  For RISC-V, as it has the advantage of being a newer
> +architecture, ``make dtbs_check W=1`` is required to not add any new warnings.
> +If in any doubt about a devicetree change, reach out to the devicetree
> +maintainers.
> +
> +Branches and Pull Requests
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Just as the main SoC tree has several branches, it is expected that
> +submaintainers will do the same. Driver, defconfig and devicetree changes should
> +all be split into separate branches and appear in separate pull requests to the
> +SoC maintainers.  Each branch should be usable by itself and avoid
> +regressions that originate from dependencies on other branches.
> +
> +Small sets of patches can also be sent as separate emails to soc@kernel.org,
> +grouped into the same categories.
> +
> +If changes do not fit into the normal patterns, there can be additional
> +top-level branches, e.g. for a treewide rework, or the addition of new SoC
> +platforms including dts files and drivers.
> +
> +Branches with a lot of changes can benefit from getting split up into separate
> +topics branches, even if they end up getting merged into the same branch of the
> +SoC tree.  An example here would be one branch for devicetree warning fixes, one
> +for a rework and one for newly added boards.
> +
> +Another common way to split up changes is to send an early pull request with the
> +majority of the changes at some point between rc1 and rc4, following up with one
> +or more smaller pull requests towards the end of the cycle that can add late
> +changes or address problems idenfied while testing the first set.

                               identified

> +
> +While there is no cut-off time for late pull requests, it helps to only send
> +small branches as time gets closer to the merge window.
> +
> +Pull requests for bugfixes for the current release can be sent at any time, but
> +again having multiple smaller branches is better than trying to combine too many
> +patches into one pull request.
> +
> +The subject line of a pull request should begin with "[GIT PULL]" and made using
> +a signed tag, rather than a branch.  This tag should contain a short description
> +summarising the changes in the pull request.  For more detail on sending pull
> +requests, please see :ref:`pullrequests`.

>  

-- 
~Randy
