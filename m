Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AE566BDD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjAPM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAPM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:29:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027741E1D8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:29:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 20so2870770plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UgkiqTyzwjniAuy/4fFbJUSojpXdp/wFJb1dpVCiEGk=;
        b=sCNVxPxIb7uyzLHdTpxl7N+kYeKmd4vJRxoISdWWCpMJT0PCBPTHNYFwzuj+e0s/Qj
         lk3fPv+WqrEtccAuvc2OKQd3QY1cIGvl8jBKHR8MhjNImtpguFPSmkAuwpVyiqeB3ZTQ
         CIf5IdR5Ck4QOjDsBXPtCLllzO6OWNJs62D07+2ddtIOTbEBzlDqyDRSgBeWYWLHysyj
         27UPFhCl+7vE1emT2gLiOVaOu5jR0s7OR1JDh3X6mWpg7VcxN4rSTV3fuyA7uWhAAgVz
         rtl8aPOzdmBlfYcu8GGfo4uf6vBRivSvtISLBa4/FfBc2LnHbG1AfnXiBWNexSDNgUTa
         i0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgkiqTyzwjniAuy/4fFbJUSojpXdp/wFJb1dpVCiEGk=;
        b=NMpr6w6mQk84fOYztWp+YZ7kKsZBYWVn3AmrbDkJoB3jx+yeXY/DYt1f9Hss+IEiM7
         1J9zz5AVpOJtu9q6Ak7blsvSR3POogKjRR67eRGM7brJVd6jnCP3KQagNDgksHQzXrsd
         39bm6Ukmpwr2ZKyOSjUDx2f5c87ShiRa9cdqtS1+2ajB8uGLLBy9W3uL9IcX0+91gmAl
         Gf472xoxVHnS67SRpYV/6iokDiI13ufTIyAOWCUR3DGFMQWnPhX7SJORbaQW667MFprv
         zanRBkyn5fNvo2BuyGzvCJd+emWjVpxhruQT/GCcPkrH9T5qbHCkKHk0ZjjNeS+73Hl/
         axVg==
X-Gm-Message-State: AFqh2ko4DseRuyWLPCdZGIxb24D/ntmDaJ4pPuUIEV6b0GWgnftEsoDD
        k7PBeQ0pnLk2isYbNJs3zcVC3K+5X6Th0zNTrmDnJg==
X-Google-Smtp-Source: AMrXdXtA2Bg5ja5lpxx0bEnT1Eb8pttIwvCZma9VPnbGiWcJFWy4BTZ58JbxT9mWoyoZOCyW+ZhlZAeLkfBWz/SQHCE=
X-Received: by 2002:a17:902:d14c:b0:194:957b:e81a with SMTP id
 t12-20020a170902d14c00b00194957be81amr257209plt.114.1673872174441; Mon, 16
 Jan 2023 04:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20221219234638.3661-1-mike.leach@linaro.org> <20221219234638.3661-7-mike.leach@linaro.org>
 <Y6KDqe26J8RyoJIV@debian.me>
In-Reply-To: <Y6KDqe26J8RyoJIV@debian.me>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 16 Jan 2023 12:29:23 +0000
Message-ID: <CAJ9a7VivKKZi8DvNFurb6V0ds1qjvtD+BV7Don+kGSnwrNFY5g@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] Documentation: coresight: docs for config load via configfs
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Wed, 21 Dec 2022 at 03:55, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Dec 19, 2022 at 11:46:38PM +0000, Mike Leach wrote:
> > diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
> > index 6d5ffa6f7347..109053eb1b93 100644
> > --- a/Documentation/trace/coresight/coresight-config.rst
> > +++ b/Documentation/trace/coresight/coresight-config.rst
> > @@ -141,11 +141,11 @@ Mount configfs as normal and the 'cs-syscfg' subsystem will appear::
> >      $ ls /config
> >      cs-syscfg  stp-policy
> >
> > -This has two sub-directories::
> > +This has two sub-directories, with the load and unload attribute files::
> >
> >      $ cd cs-syscfg/
> >      $ ls
> > -    configurations  features
> > +    configurations features load  unload
> >
> >  The system has the configuration 'autofdo' built in. It may be examined as
> >  follows::
> > @@ -278,9 +278,16 @@ Creating and Loading Custom Configurations
> >  ==========================================
> >
> >  Custom configurations and / or features can be dynamically loaded into the
> > -system by using a loadable module.
> > +system by using a loadable module, or by loading a binary configuration
> > +file in configfs.
> >
> > -An example of a custom configuration is found in ./samples/coresight.
> > +Loaded configurations can use previously loaded features. The system will
> > +ensure that it is not possible to unload a feature that is currently in
> > +use, by enforcing the unload order as the strict reverse of the load order.
> > +
> > +
> > +Using a Loadable Module
> > +-----------------------
> >
> >  This creates a new configuration that uses the existing built in
> >  strobing feature, but provides a different set of presets.
> > @@ -289,6 +296,187 @@ When the module is loaded, then the configuration appears in the configfs
> >  file system and is selectable in the same way as the built in configuration
> >  described above.
> >
> > -Configurations can use previously loaded features. The system will ensure
> > -that it is not possible to unload a feature that is currently in use, by
> > -enforcing the unload order as the strict reverse of the load order.
> > +The file 'coresight-cfg-sample.c' contains the configuration and module
> > +initialisation code needed to create the loadable module.
> > +
> > +This will be built alongside the kernel modules if select in KConfig.
>
> What config options (CONFIG_) are required for above to work?
>
> > +
> > +An example of a custom configuration module is found in './samples/coresight'.
> > +
> > +Using a Binary Configuration File
> > +---------------------------------
> > +
> > +The './tools/coresight' directory contains example programs to generate and
> > +read and print binary configuration files.
> > +
> > +Building the tools creates the 'coresight-cfg-file-gen' program that will
> > +generate a configuration binary 'example1.cscfg' that can be loaded into the
> > +system using configfs. The configuration declared in the source file
> > +'coresight-cfg-example1.c' is named 'autofdo3' - the name that will be used
> > +once loaded.
> > +
> > +The source files 'coresight-cfg-bufw.h' and 'coresight-cfg-bufw.c' provide a
> > +standard function to convert a configuration declared in 'C' into the correct
> > +binary buffer format. These files can be re-used to create new custom
> > +configurations. Alternatively, addition examples can be added to the
>
> s/addition/additional/
>
> > +'coresight-cfg-file-gen' program::
> > +
> > +    $ ./coresight-cfg-file-gen
> > +    Coresight Configuration file Generator
> > +
> > +    Generating example1 example
> > +    Generating example2 example
> > +
> > +The program 'coresight-cfg-file-read' can read back and print a configuration
> > +binary. This is built using the file reader from the driver code
> > +(coresight-config-file.c), which is copied over into './tools/coresight' at
> > +build time.::
> > +
> > +    ./coresight-cfg-file-read example1.cscfg
> > +    CoreSight Configuration file reader
> > +    ============================================
> > +
> > +    Configuration 1
> > +    Name:- autofdo3
> > +    Description:-
> > +    Setup ETMs with strobing for autofdo
> > +    Supplied presets allow experimentation with mark-space ratio for various loads
> > +
> > +    Uses 1 features:-
> > +    Feature-1: strobing
> > +
> > +    Provides 4 sets of preset values, 2 presets per set
> > +    set[0]: 0x7d0, 0x64,
> > +    set[1]: 0x7d0, 0x3e8,
> > +    set[2]: 0x7d0, 0x1388,
> > +    set[3]: 0x7d0, 0x2710,
> > +
> > +    ============================================
> > +    File contains no features
> > +
> > +There are additional attributes in the cs-syscfg directory - load and
> > +unload that can be used to load and unload configuration binary files. To
> > +load, 'cat' the binary config into the load attribute::
> > +
> > +    $ ls /config/cs-syscfg
> > +    configurations features  load  unload
> > +    $ cat example1.cscfg > /config/cs-syscfg/load
> > +    $ ls /config/cs-syscfg/configurations/
> > +    autofdo  autofdo3
> > +
> > +To unload, use the same file in the unload attribute::
> > +
> > +    $ cat example1.cscfg > /config/cs-syscfg/unload
> > +    ls /config/cs-syscfg/configurations/
> > +    autofdo
> > +
> > +
> > +
> > +Binary Configuration File Format
> > +--------------------------------
> > +
> > +The file format is defined in the source file **coresight-config-file.h**
>
> Use single-quote for identifier names for consistency here.
>
> > +
> > +The source reader and generator examples produce a binary of this format.
> > +
> > +This arrangement is reproduced below:-
> > +
> > +Overall File structure
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +   [cscfg_file_header]   // Mandatory
> > +   [CONFIG_ELEM]*        // Optional - multiple, defined by cscfg_file_header.nr_configs
> > +   [FEATURE_ELEM]*       // Optional - multiple, defined by cscfg_file_header.nr_features
> > +
> > +File is invalid if both [CONFIG_ELEM] and [FEATURE_ELEM] are omitted.
> > +
> > +A file that contains only [FEATURE_ELEM] may be loaded, and the features used
> > +by subsequently loaded files with [CONFIG_ELEM] elements.
> > +
> > +Element Name Strings
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +Configuration name strings are required to consist of alphanumeric characters and '_' only. Other special characters are not permitted.
> > +
> > +::
> > +   my_config_2          // is a valid name.
> > +   this-bad-config#5    // this will not work
>
> Instead of using code-block for name examples, what about "... For
> example, foo_bar is a valid name where as foo-bar# is not."?
>
> > +
> > +This is in order to comply with the requirements of the perf command line.
> > +
> > +It is recommended that Feature and Parameter names use the same convention to allow for future enhancements to the command line syntax.
> > +
> > +CONFIG_ELEM element
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +   [cscfg_file_elem_header]                // header length value to end of feature strings.
> > +   [cscfg_file_elem_str]                   // name of the configuration.
> > +                                           // (see element string name requirements)
> > +   [cscfg_file_elem_str]                   // description of configuration.
> > +   [u16 value](nr_presets)                 // number of defined sets presets values.
> > +   [u32 value](nr_total_params)            // total parameters defined by all used features.
> > +   [u16 value](nr_feat_refs)               // number of features referenced by the configuration
> > +   [u64 values] * (nr_presets * nr_total_params)     // the preset values.
> > +   [cscfg_file_elem_str] * (nr_feat_refs)  // names of features used in the configurations.
> > +
> > +FEATURE_ELEM element
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +   [cscfg_file_elem_header]                // header length is total bytes to end of param structures.
> > +   [cscfg_file_elem_str]                   // feature name.
> > +   [cscfg_file_elem_str]                   // feature description.
> > +   [u32 value](match_flags)                // flags to associate the feature with a device.
> > +   [u16 value](nr_regs)                    // number of registers.
> > +   [u16 value](nr_params)                  // number of parameters.
> > +   [cscfg_regval_desc struct] * (nr_regs)  // register definitions
> > +   [PARAM_ELEM] * (nr_params)              // parameters definitions
> > +
> > +PARAM_ELEM element
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +::
> > +
> > +   [cscfg_file_elem_str]         // parameter name.
> > +   [u64 value](param_value)      // initial value.
> > +
> > +Additional definitions.
> > +~~~~~~~~~~~~~~~~~~~~~~~
>
> Trim trailing period for section names
>
> > +
> > +The following structures are defined in **coresight-config-file.h**
> > +
> > + * **struct cscfg_file_header** : This structure contains an initial magic number, the total
> > +   length of the file, and the number of configurations and features in the file.
> > + * **struct cscfg_file_elem_header**: This defines the total length and type of a CONFIG_ELEM
> > +   or a FEATURE_ELEM.
> > + * **struct cscfg_file_elem_str**: This defines a string and its length.
>
> Again, for consistency, wrap identifier names in single-quotes.
>
> > +
> > +The magic number in cscfg_file_header is defined as two bitfields::
> > +
> > +   [31:8] Fixed magic number to identify file type.
> > +   [7:0]  Current file format version.
> > +
> > +The following defines determine the maximum overall file size and maximum individual
> > +string size::
> > +
> > +   CSCFG_FILE_MAXSIZE       // maximum overall file size.
> > +   CSCFG_FILE_STR_MAXSIZE   // maximum individual string size.
>
> For parameter lists in elements, use bullet lists instead.
>
> > +
> > +Load Dependencies.
> > +~~~~~~~~~~~~~~~~~~
>
> Trim trailing period for section names.
> > +
> > +Files may be unloaded only in the strict reverse order of loading. This is enforced by the
> > +configuration system.
> > +
> > +This is to ensure that any load dependencies are maintained.
> > +
> > +A configuration file that contains a CONFIG_ELEM that references named features "feat_A" and "feat_B" will load only if either:-
> > +a) "feat_A" and/or "feat_B" has been loaded previously, or are present as built-in / module loaded features.
> > +b) "feat_A" and/or "feat_B" are declared as FEAT_ELEM in the same file as the CONFIG_ELEM.
>
> Separate the preceding paragraph and the list with a blank line in order
> for the list to be rendered as list.
>

The next version will contain all the adjustments that you suggested,
though rather than using single quotes, I have changed all the
occurrences to consistently the double back tick to make the filenames
etc fixed width font.

Thanks for the review

Mike


> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
