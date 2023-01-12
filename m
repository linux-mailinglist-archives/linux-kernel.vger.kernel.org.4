Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306DF666E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjALJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbjALJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:40:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFC4733A;
        Thu, 12 Jan 2023 01:38:57 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so5104446pjl.0;
        Thu, 12 Jan 2023 01:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tru7c3qZlnOtG/XjbvP3WP2+wnoKC+stYPnx+ECyeyI=;
        b=VxbeGuGaFfrAbIKQTBsPPXe+T1u1++0o22Jw0EJ53Ra4koyzSfzNB9at4FOrP/U9RG
         NNcBYCcnkyqDqzM92H03LoAH4nRZALcgd3jyuF/NXk1qf5oe4knrhh7WynN9GNSDRgNL
         yP+0J7um1lRruwwN0cNRdC/CAGVXYCCWINNJLUJPtPjfH0e35+eKFN1vV/lrRp3b5YhC
         BcbfbfrGqHOg6HG2E79kMBU7nm3pgp77fpRshaEW7CcTHIC1o0VEeUS/Qf8noMVLGD0w
         ZELcnoLdrpz9kZfI5SqEPxXBov/pTMktcBzz/2zTGsLAWmdhM9MIW+5OQlMylHRF1QY/
         EkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tru7c3qZlnOtG/XjbvP3WP2+wnoKC+stYPnx+ECyeyI=;
        b=Ki5JWoGhFPbRADNrRBpgXOqLKU+WBBawlAX68gcUcuvi9BwVyBaclNR8iHIGqppJ57
         zmYCdyAwOw/w+UV/viDyTuHogX/NyF6Jt9Hh5Ve035plWQxUhxeuaUsLy34JRRlzeav+
         Xn0Ukq+QktTpss7sAtJ1I9z6//ISV7bHfpXmJ1SLS0Njyb71Qwsl06VetJLHCe8qqGvs
         rg70DgNqNJ/4rN1ymarUwu4wxzXLSu2w8dANgY76ycxTuKIlxFlsqCJeXH3DlitLjSf1
         phWXFCvPnRO4TZBfPGR6PiLte4QHiv0aA4FzeVeB/OP2feoDkEThus7xjx5p1PfiLbC/
         3CHg==
X-Gm-Message-State: AFqh2kqKI4Jn/R3RsDdWFRA/abWGTWT0fooLoFQ71eVBhu057bNFBo6l
        PKQsZqvJv+gHgeb++kcuLB0=
X-Google-Smtp-Source: AMrXdXvZbwgHwJzupNLmrLj7PvQ17kU57Ffls5iWwz3XZqJIrMRKarz/wlraTSQNfIl+nQafou3iEw==
X-Received: by 2002:a05:6a20:4996:b0:9d:efbf:6607 with SMTP id fs22-20020a056a20499600b0009defbf6607mr79696277pzb.21.1673516337300;
        Thu, 12 Jan 2023 01:38:57 -0800 (PST)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00188f3970d4asm11742740plk.163.2023.01.12.01.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 01:38:56 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 43BA61043DC; Thu, 12 Jan 2023 16:38:53 +0700 (WIB)
Date:   Thu, 12 Jan 2023 16:38:53 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y7/VLTiPSkSulj5D@debian.me>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FXqNfPuc54X28R0g"
Content-Disposition: inline
In-Reply-To: <20230110152358.2641910-3-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FXqNfPuc54X28R0g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 05:23:58PM +0200, Mike Rapoport wrote:
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/phys=
ical_memory.rst
> index 2ab7b8c1c863..9ad42ff22d88 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -3,3 +3,343 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Physical Memory
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Linux is available for a wide range of architectures so there is a need =
for an
> +architecture-independent abstraction to represent the physical memory. T=
his
> +chapter describes the structures used to manage physical memory in a run=
ning
> +system.
> +
> +The first principal concept prevalent in the memory management is
> +`Non-Uniform Memory Access (NUMA)
> +<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`_.
> +With multi-core and multi-socket machines, memory may be arranged into b=
anks
> +that incur a different cost to access depending on the =E2=80=9Cdistance=
=E2=80=9D from the
> +processor. For example, there might be a bank of memory assigned to each=
 CPU or
> +a bank of memory very suitable for DMA near peripheral devices.
> +
> +Each bank is called a node and the concept is represented under Linux by=
 a
> +``struct pglist_data`` even if the architecture is UMA. This structure is
> +always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` stru=
cture
> +for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
> +``nid`` is the ID of that node.
> +
> +For NUMA architectures, the node structures are allocated by the archite=
cture
> +specific code early during boot. Usually, these structures are allocated
> +locally on the memory bank they represent. For UMA architectures, only o=
ne
> +static ``pg_data_t`` structure called ``contig_page_data`` is used. Node=
s will
> +be discussed further in Section :ref:`Nodes <nodes>`
> +
> +The entire physical address space is partitioned into one or more blocks
> +called zones which represent ranges within memory. These ranges are usua=
lly
> +determined by architectural constraints for accessing the physical memor=
y.
> +The memory range within a node that corresponds to a particular zone is
> +described by a ``struct zone``, typedeffed to ``zone_t``. Each zone has
> +one of the types described below.
> +
> +* ``ZONE_DMA`` and ``ZONE_DMA32`` represent memory suitable for DMA by
> +  peripheral devices that cannot access all of the addressable memory.
> +  Depending on the architecture, either of these zone types or even they=
 both
> +  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
> +  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may=
 need
> +  both zones as they support peripherals with different DMA addressing
> +  limitations.
> +
> +* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kerne=
l all
> +  the time. DMA operations can be performed on pages in this zone if the=
 DMA
> +  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
> +  always enabled.
> +
> +* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covere=
d by a
> +  permanent mapping in the kernel page tables. The memory in this zone i=
s only
> +  accessible to the kernel using temporary mappings. This zone is availa=
ble
> +  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM=
``.
> +
> +* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NOR=
MAL``.
> +  The difference is that most pages in ``ZONE_MOVABLE`` are movable. Tha=
t means
> +  that while virtual addresses of these pages do not change, their conte=
nt may
> +  move between different physical pages. ``ZONE_MOVABLE`` is only enable=
d when
> +  one of ``kernelcore``, ``movablecore`` and ``movable_node`` parameters=
 is
> +  present in the kernel command line. See :ref:`Page migration
> +  <page_migration>` for additional details.
> +
> +* ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and=
 GPU.
> +  It has different characteristics than RAM zone types and it exists to =
provide
> +  :ref:`struct page <Pages>` and memory map services for device driver
> +  identified physical address ranges. ``ZONE_DEVICE`` is enabled with
> +  configuration option ``CONFIG_ZONE_DEVICE``.
> +
> +It is important to note that many kernel operations can only take place =
using
> +``ZONE_NORMAL`` so it is the most performance critical zone. Zones are
> +discussed further in Section :ref:`Zones <zones>`.
> +
> +The relation between node and zone extents is determined by the physical=
 memory
> +map reported by the firmware, architectural constraints for memory addre=
ssing
> +and certain parameters in the kernel command line.
> +
> +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of R=
AM the
> +entire memory will be on node 0 and there will be three zones: ``ZONE_DM=
A``,
> +``ZONE_NORMAL`` and ``ZONE_HIGHMEM``::
> +
> +  0                                                            2G
> +  +-------------------------------------------------------------+
> +  |                            node 0                           |
> +  +-------------------------------------------------------------+
> +
> +  0         16M                    896M                        2G
> +  +----------+-----------------------+--------------------------+
> +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> +  +----------+-----------------------+--------------------------+
> +
> +
> +With a kernel built with ``ZONE_DMA`` disabled and ``ZONE_DMA32`` enable=
d and
> +booted with ``movablecore=3D80%`` parameter on an arm64 machine with 16 =
Gbytes of
> +RAM equally split between two nodes, there will be ``ZONE_DMA32``,
> +``ZONE_NORMAL`` and ``ZONE_MOVABLE`` on node 0, and ``ZONE_NORMAL`` and
> +``ZONE_MOVABLE`` on node 1::
> +
> +
> +  1G                                9G                         17G
> +  +--------------------------------+ +--------------------------+
> +  |              node 0            | |          node 1          |
> +  +--------------------------------+ +--------------------------+
> +
> +  1G       4G        4200M          9G          9320M          17G
> +  +---------+----------+-----------+ +------------+-------------+
> +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> +  +---------+----------+-----------+ +------------+-------------+
> +
> +.. _nodes:
> +
> +Nodes
> +=3D=3D=3D=3D=3D
> +
> +As we have mentioned, each node in memory is described by a ``pg_data_t`=
` which
> +is a typedef for a ``struct pglist_data``. When allocating a page, by de=
fault
> +Linux uses a node-local allocation policy to allocate memory from the no=
de
> +closest to the running CPU. As processes tend to run on the same CPU, it=
 is
> +likely the memory from the current node will be used. The allocation pol=
icy can
> +be controlled by users as described in
> +Documentation/admin-guide/mm/numa_memory_policy.rst.
> +
> +Most NUMA architectures maintain an array of pointers to the node
> +structures. The actual structures are allocated early during boot when
> +architecture specific code parses the physical memory map reported by the
> +firmware. The bulk of the node initialization happens slightly later in =
the
> +boot process by free_area_init() function, described later in Section
> +:ref:`Initialization <initialization>`.
> +
> +
> +Along with the node structures, kernel maintains an array of ``nodemask_=
t``
> +bitmasks called ``node_states``. Each bitmask in this array represents a=
 set of
> +nodes with particular properties as defined by ``enum node_states``:
> +
> +``N_POSSIBLE``
> +  The node could become online at some point.
> +``N_ONLINE``
> +  The node is online.
> +``N_NORMAL_MEMORY``
> +  The node has regular memory.
> +``N_HIGH_MEMORY``
> +  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabl=
ed
> +  aliased to ``N_NORMAL_MEMORY``.
> +``N_MEMORY``
> +  The node has memory(regular, high, movable)
> +``N_CPU``
> +  The node has one or more CPUs
> +
> +For each node that has a property described above, the bit corresponding=
 to the
> +node ID in the ``node_states[<property>]`` bitmask is set.
> +
> +For example, for node 2 with normal memory and CPUs, bit 2 will be set i=
n ::
> +
> +  node_states[N_POSSIBLE]
> +  node_states[N_ONLINE]
> +  node_states[N_NORMAL_MEMORY]
> +  node_states[N_MEMORY]
> +  node_states[N_CPU]
> +
> +For various operations possible with nodemasks please refer to
> +``include/linux/nodemask.h``.
> +
> +Among other things, nodemasks are used to provide macros for node traver=
sal,
> +namely ``for_each_node()`` and ``for_each_online_node()``.
> +
> +For instance, to call a function foo() for each online node::
> +
> +	for_each_online_node(nid) {
> +		pg_data_t *pgdat =3D NODE_DATA(nid);
> +
> +		foo(pgdat);
> +	}
> +
> +Node structure
> +--------------
> +
> +The nodes structure ``struct pglist_data`` is declared in
> +``include/linux/mmzone.h``. Here we briefly describe fields of this
> +structure:
> +
> +General
> +~~~~~~~
> +
> +``node_zones``
> +  The zones for this node.  Not all of the zones may be populated, but i=
t is
> +  the full list. It is referenced by this node's node_zonelists as well =
as
> +  other node's node_zonelists.
> +
> +``node_zonelists``
> +  The list of all zones in all nodes. This list defines the order of zon=
es
> +  that allocations are preferred from. The ``node_zonelists`` is set up =
by
> +  ``build_zonelists()`` in ``mm/page_alloc.c`` during the initialization=
 of
> +  core memory management structures.
> +
> +``nr_zones``
> +  Number of populated zones in this node.
> +
> +``node_mem_map``
> +  For UMA systems that use FLATMEM memory model the 0's node
> +  ``node_mem_map`` is array of struct pages representing each physical f=
rame.
> +
> +``node_page_ext``
> +  For UMA systems that use FLATMEM memory model the 0's node
> +  ``node_page_ext`` is array of extensions of struct pages. Available on=
ly
> +  in the kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
> +
> +``node_start_pfn``
> +  The page frame number of the starting page frame in this node.
> +
> +``node_present_pages``
> +  Total number of physical pages present in this node.
> +
> +``node_spanned_pages``
> +  Total size of physical page range, including holes.
> +
> +``node_size_lock``
> +  A lock that protects the fields defining the node extents. Only define=
d when
> +  at least one of ``CONFIG_MEMORY_HOTPLUG`` or
> +  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` configuration options are enabled.
> +  ``pgdat_resize_lock()`` and ``pgdat_resize_unlock()`` are provided to
> +  manipulate ``node_size_lock`` without checking for ``CONFIG_MEMORY_HOT=
PLUG``
> +  or ``CONFIG_DEFERRED_STRUCT_PAGE_INIT``.
> +
> +``node_id``
> +  The Node ID (NID) of the node, starts at 0.
> +
> +``totalreserve_pages``
> +  This is a per-node reserve of pages that are not available to userspace
> +  allocations.
> +
> +``first_deferred_pfn``
> +  If memory initialization on large machines is deferred then this is th=
e first
> +  PFN that needs to be initialized. Defined only when
> +  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` is enabled
> +
> +``deferred_split_queue``
> +  Per-node queue of huge pages that their split was deferred. Defined on=
ly when ``CONFIG_TRANSPARENT_HUGEPAGE`` is enabled.
> +
> +``__lruvec``
> +  Per-node lruvec holding LRU lists and related parameters. Used only wh=
en
> +  memory cgroups are disabled. It should not be accessed directly, use
> +  ``mem_cgroup_lruvec()`` to look up lruvecs instead.
> +
> +Reclaim control
> +~~~~~~~~~~~~~~~
> +
> +See also :ref:`Page Reclaim <page_reclaim>`.
> +
> +``kswapd``
> +  Per-node instance of kswapd kernel thread.
> +
> +``kswapd_wait``, ``pfmemalloc_wait``, ``reclaim_wait``
> +  Workqueues used to synchronize memory reclaim tasks
> +
> +``nr_writeback_throttled``
> +  Number of tasks that are throttled waiting on dirty pages to clean.
> +
> +``nr_reclaim_start``
> +  Number of pages written while reclaim is throttled waiting for writeba=
ck.
> +
> +``kswapd_order``
> +  Controls the order kswapd tries to reclaim
> +
> +``kswapd_highest_zoneidx``
> +  The highest zone index to be reclaimed by kswapd
> +
> +``kswapd_failures``
> +  Number of runs kswapd was unable to reclaim any pages
> +
> +``min_unmapped_pages``
> +  Minimal number of unmapped file backed pages that cannot be reclaimed.
> +  Determined by ``vm.min_unmapped_ratio`` sysctl. Only defined when
> +  ``CONFIG_NUMA`` is enabled.
> +
> +``min_slab_pages``
> +  Minimal number of SLAB pages that cannot be reclaimed. Determined by
> +  ``vm.min_slab_ratio sysctl``. Only defined when ``CONFIG_NUMA`` is ena=
bled
> +
> +``flags``
> +  Flags controlling reclaim behavior.
> +
> +Compaction control
> +~~~~~~~~~~~~~~~~~~
> +
> +``kcompactd_max_order``
> +  Page order that kcompactd should try to achieve.
> +
> +``kcompactd_highest_zoneidx``
> +  The highest zone index to be compacted by kcompactd.
> +
> +``kcompactd_wait``
> +  Workqueue used to synchronize memory compaction tasks.
> +
> +``kcompactd``
> +  Per-node instance of kcompactd kernel thread.
> +
> +``proactive_compact_trigger``
> +  Determines if proactive compaction is enabled. Controlled by
> +  ``vm.compaction_proactiveness`` sysctl.
> +
> +Statistics
> +~~~~~~~~~~
> +
> +``per_cpu_nodestats``
> +  Per-CPU VM statistics for the node
> +
> +``vm_stat``
> +  VM statistics for the node.
> +
> +.. _zones:
> +
> +Zones
> +=3D=3D=3D=3D=3D
> +
> +.. admonition:: Stub
> +
> +   This section is incomplete. Please list and describe the appropriate =
fields.
> +
> +.. _pages:
> +
> +Pages
> +=3D=3D=3D=3D=3D
> +
> +.. admonition:: Stub
> +
> +   This section is incomplete. Please list and describe the appropriate =
fields.
> +
> +.. _folios:
> +
> +Folios
> +=3D=3D=3D=3D=3D=3D
> +
> +.. admonition:: Stub
> +
> +   This section is incomplete. Please list and describe the appropriate =
fields.
> +
> +.. _initialization:
> +
> +Initialization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. admonition:: Stub
> +
> +   This section is incomplete. Please list and describe the appropriate =
fields.
=20
The doc LGTM, thanks. I leave the actual content review to mm people.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--FXqNfPuc54X28R0g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY7/VJwAKCRD2uYlJVVFO
owSqAQC3gn/CY5fDsaH6YNULi329fZdALUnU6kit1uKdNuDMEAEA1PyFR2WrWAGw
P8ucOfkkoNEq7Q6f5ybxEelEZpWqNAU=
=LLtb
-----END PGP SIGNATURE-----

--FXqNfPuc54X28R0g--
